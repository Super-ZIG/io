// Copyright (c) 2025 SuperZIG All rights reserved.
//
// repo: https://github.com/Super-ZIG/io
// docs: https://super-zig.github.io/io/terminal
//
// Made with ❤️ by Maysara
//
// maysara.elshewehy@gmail.com.
// https://github.com/maysara-elshewehy



// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    const std = @import("std");
    const builtin = @import("builtin");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Starts the CLI application.
    pub fn start(commands: []const command, options: []const option, debug: bool) !void {
        if (commands.len > MAX_COMMANDS) {
            return error.TooManyCommands;
        }
        if (options.len > MAX_OPTIONS) {
            return error.TooManyOptions;
        }

        // Create a general-purpose allocator for managing memory during execution
        var gpa = std.heap.GeneralPurposeAllocator(.{}){};
        defer _ = gpa.deinit();
        const allocator = gpa.allocator();

        // Retrieve the command-line arguments in a cross-platform manner
        const args = try std.process.argsAlloc(allocator);
        defer std.process.argsFree(allocator, args);

        try startWithArgs(commands, options, args, debug);
    }

    /// Starts the CLI application with provided arguments.
    pub fn startWithArgs(commands: []const command, options: []const option, args: anytype, debug: bool) !void {
        if (args.len < 2) {
            if(debug) std.debug.print("No command provided by user!\n", .{});
            return Error.NoArgsProvided;
        }

        // Extract the name of the command (the second argument after the program name)
        const command_name = args[1];
        var detected_command: ?command = null;

        // Search through the list of available commands to find a match
        for (commands) |cmd| {
            if (std.mem.eql(u8, cmd.name, command_name)) {
                detected_command = cmd;
                break;
            }
        }

        // If no matching command is found, return an error
        if (detected_command == null) {
            if(debug) std.debug.print("Unknown command: {s}\n", .{command_name});
            return Error.UnknownCommand;
        }

        // Retrieve the matched command from the optional variable
        const cmd = detected_command.?;

        if(debug) std.debug.print("Detected command: {s}\n", .{cmd.name});

        // Allocate memory for detected options based on remaining arguments
        var detected_options: [MAX_OPTIONS]option = undefined;
        var detected_len : usize = 0;
        var i: usize = 2;

        // Parsing options to capture their values
        while (i < args.len) {
            const arg = args[i];

            if (std.mem.startsWith(u8, arg, "-")) {
                const option_name = if (std.mem.startsWith(u8, arg[1..], "-")) arg[2..] else arg[1..];
                var matched_option: ?option = null;

                for (options) |opt| {
                    if (std.mem.eql(u8, option_name, opt.long) or (option_name.len == 1 and option_name[0] == opt.short)) {
                        matched_option = opt;
                        break;
                    }
                }

                if (matched_option == null) {
                    if(debug) std.debug.print("Unknown option: {s}\n", .{arg});
                    return Error.UnknownOption;
                }

                var opt = matched_option.?;

                // Detect the value for the option
                if (i + 1 < args.len and !std.mem.startsWith(u8, args[i + 1], "-")) {
                    opt.value = args[i + 1];
                    i += 1;
                } else {
                    opt.value = "";
                }

                if (detected_len >= MAX_OPTIONS) {
                    return error.TooManyOptions;
                }

                detected_options[detected_len] = opt;
                detected_len += 1;
            } else {
                if(debug) std.debug.print("Unexpected argument: {s}\n", .{arg});
                return Error.UnexpectedArgument;
            }

            i += 1;
        }

        // Slice the detected options to the actual number of detected options
        const used_options = detected_options[0..detected_len];

        // Ensure all required options for the detected command are provided
        for (cmd.req) |req_option| {
            var found = false;

            for (used_options) |opt| {
                if (std.mem.eql(u8, req_option, opt.name)){
                    found = true; break;
                }
            }

            if (!found) {
                if(debug) std.debug.print("Missing required option: {s}\n", .{req_option});
                return Error.MissingRequiredOption;
            }
        }

        // Execute the command's associated function with the detected options
        if (!cmd.func(used_options)) { return Error.CommandExecutionFailed; }
        else {
            // Execute option functions
            for (used_options) |opt| {
                if(opt.func == null) continue;

                const result = opt.func.?(opt.value);

                if (!result) {
                    if(debug) std.debug.print("Option function execution failed: {s}\n", .{opt.name});
                    return Error.CommandExecutionFailed;
                }
            }
        }

        // If execution reaches this point, the command was executed successfully
        if(debug) std.debug.print("Command executed successfully: {s}\n", .{cmd.name});
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ ---- ══════════════════════════════════════╗

    pub const MAX_COMMANDS: u8 = 10;
    pub const MAX_OPTIONS: u8 = 20;

    const Byte    = u8;
    const Slice   = []const Byte;
    const Slices  = []const Slice;

    /// Structure to represent the type of command.
    pub const command = struct {
        name : Slice,                   // Name of the command
        func : fnType,                  // Function to execute the command
        req  : Slices = &.{},           // Required options
        opt  : Slices = &.{},           // Optional options
        const fnType = *const fn ([]const option) bool;
    };

    /// Structure to represent the type of option.
    pub const option = struct {
        name  : Slice,                  // Name of the option
        func  : ?fnType = undefined,    // Function to execute the option
        short : Byte,                   // Short form, e.g., -n|-N
        long  : Slice,                  // Long form, e.g., --name
        value : Slice = "",             // Value of the option
        const fnType = *const fn (Slice) bool;
    };

    /// -
    pub const Error = error {
        NoArgsProvided,
        UnknownCommand,
        UnknownOption,
        MissingRequiredOption,
        UnexpectedArgument,
        CommandExecutionFailed,
        TooManyCommands,
        TooManyOptions,
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝