const std = @import("std");

pub const AddOnType = enum {
    auto_snapshot,
    stop_instance_on_idle,

    pub const json_field_names = .{
        .auto_snapshot = "AutoSnapshot",
        .stop_instance_on_idle = "StopInstanceOnIdle",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto_snapshot => "AutoSnapshot",
            .stop_instance_on_idle => "StopInstanceOnIdle",
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
