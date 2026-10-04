const std = @import("std");

pub const CodeGenerationStatus = enum {
    create_in_progress,
    create_complete,
    create_failed,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_complete = "CREATE_COMPLETE",
        .create_failed = "CREATE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_in_progress => "CREATE_IN_PROGRESS",
            .create_complete => "CREATE_COMPLETE",
            .create_failed => "CREATE_FAILED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
