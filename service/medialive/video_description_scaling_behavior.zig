const std = @import("std");

/// Video Description Scaling Behavior
pub const VideoDescriptionScalingBehavior = enum {
    default,
    stretch_to_output,
    smart_crop,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .stretch_to_output = "STRETCH_TO_OUTPUT",
        .smart_crop = "SMART_CROP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .stretch_to_output => "STRETCH_TO_OUTPUT",
            .smart_crop => "SMART_CROP",
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
