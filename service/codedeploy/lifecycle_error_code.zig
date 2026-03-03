const std = @import("std");

pub const LifecycleErrorCode = enum {
    success,
    script_missing,
    script_not_executable,
    script_timed_out,
    script_failed,
    unknown_error,

    pub const json_field_names = .{
        .success = "Success",
        .script_missing = "ScriptMissing",
        .script_not_executable = "ScriptNotExecutable",
        .script_timed_out = "ScriptTimedOut",
        .script_failed = "ScriptFailed",
        .unknown_error = "UnknownError",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .success => "Success",
            .script_missing => "ScriptMissing",
            .script_not_executable => "ScriptNotExecutable",
            .script_timed_out => "ScriptTimedOut",
            .script_failed => "ScriptFailed",
            .unknown_error => "UnknownError",
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
