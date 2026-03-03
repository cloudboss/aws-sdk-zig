const std = @import("std");

pub const ToolName = enum {
    execute_code,
    execute_command,
    read_files,
    list_files,
    remove_files,
    write_files,
    start_command_execution,
    get_task,
    stop_task,

    pub const json_field_names = .{
        .execute_code = "executeCode",
        .execute_command = "executeCommand",
        .read_files = "readFiles",
        .list_files = "listFiles",
        .remove_files = "removeFiles",
        .write_files = "writeFiles",
        .start_command_execution = "startCommandExecution",
        .get_task = "getTask",
        .stop_task = "stopTask",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .execute_code => "executeCode",
            .execute_command => "executeCommand",
            .read_files => "readFiles",
            .list_files => "listFiles",
            .remove_files => "removeFiles",
            .write_files => "writeFiles",
            .start_command_execution => "startCommandExecution",
            .get_task => "getTask",
            .stop_task => "stopTask",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
