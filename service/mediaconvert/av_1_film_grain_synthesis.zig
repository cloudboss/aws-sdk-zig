const std = @import("std");

/// Film grain synthesis replaces film grain present in your content with
/// similar quality synthesized AV1 film grain. We recommend that you choose
/// Enabled to reduce the bandwidth of your QVBR quality level 5, 6, 7, or 8
/// outputs. For QVBR quality level 9 or 10 outputs we recommend that you keep
/// the default value, Disabled. When you include Film grain synthesis, you
/// cannot include the Noise reducer preprocessor.
pub const Av1FilmGrainSynthesis = enum {
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
