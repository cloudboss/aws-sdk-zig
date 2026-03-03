const std = @import("std");

pub const StageRetryMode = enum {
    failed_actions,
    all_actions,

    pub const json_field_names = .{
        .failed_actions = "FAILED_ACTIONS",
        .all_actions = "ALL_ACTIONS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .failed_actions => "FAILED_ACTIONS",
            .all_actions => "ALL_ACTIONS",
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
