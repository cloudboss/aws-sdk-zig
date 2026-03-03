const std = @import("std");

/// Add texture and detail to areas of your input video content that were lost
/// after applying the Advanced input filter. To adaptively add texture and
/// reduce softness: Choose Enabled. To not add any texture: Keep the default
/// value, Disabled. We recommend that you choose Disabled for input video
/// content that doesn't have texture, including screen recordings, computer
/// graphics, or cartoons.
pub const AdvancedInputFilterAddTexture = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
            .disabled => "DISABLED",
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
