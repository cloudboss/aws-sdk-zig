const std = @import("std");

pub const AutoScalingMode = enum {
    no_scaling,
    event_based_auto_scaling,

    pub const json_field_names = .{
        .no_scaling = "NO_SCALING",
        .event_based_auto_scaling = "EVENT_BASED_AUTO_SCALING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_scaling => "NO_SCALING",
            .event_based_auto_scaling => "EVENT_BASED_AUTO_SCALING",
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
