const std = @import("std");

/// Video Description Scaling Behavior
pub const VideoDescriptionScalingBehavior = enum {
    default,
    stretch_to_output,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .stretch_to_output = "STRETCH_TO_OUTPUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .stretch_to_output => "STRETCH_TO_OUTPUT",
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
