const std = @import("std");

pub const JobEndBehavior = enum {
    stop_rollout,
    cancel,
    force_cancel,

    pub const json_field_names = .{
        .stop_rollout = "STOP_ROLLOUT",
        .cancel = "CANCEL",
        .force_cancel = "FORCE_CANCEL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .stop_rollout => "STOP_ROLLOUT",
            .cancel => "CANCEL",
            .force_cancel => "FORCE_CANCEL",
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
