const std = @import("std");

/// Keep the default value, Enabled, to adjust quantization within each frame
/// based on spatial variation of content complexity. When you enable this
/// feature, the encoder uses fewer bits on areas that can sustain more
/// distortion with no noticeable visual degradation and uses more bits on areas
/// where any small distortion will be noticeable. For example, complex textured
/// blocks are encoded with fewer bits and smooth textured blocks are encoded
/// with more bits. Enabling this feature will almost always improve your video
/// quality. Note, though, that this feature doesn't take into account where the
/// viewer's attention is likely to be. If viewers are likely to be focusing
/// their attention on a part of the screen with a lot of complex texture, you
/// might choose to disable this feature. Related setting: When you enable
/// spatial adaptive quantization, set the value for Adaptive quantization
/// depending on your content. For homogeneous content, such as cartoons and
/// video games, set it to Low. For content with a wider variety of textures,
/// set it to High or Higher.
pub const H265SpatialAdaptiveQuantization = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .enabled => "ENABLED",
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
