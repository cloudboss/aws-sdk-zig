const std = @import("std");

/// Special features, 'ADVANCED_AUDIO' 'AUDIO_NORMALIZATION' 'MGHD' or 'MGUHD'
pub const ReservationSpecialFeature = enum {
    advanced_audio,
    audio_normalization,
    mghd,
    mguhd,

    pub const json_field_names = .{
        .advanced_audio = "ADVANCED_AUDIO",
        .audio_normalization = "AUDIO_NORMALIZATION",
        .mghd = "MGHD",
        .mguhd = "MGUHD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .advanced_audio => "ADVANCED_AUDIO",
            .audio_normalization => "AUDIO_NORMALIZATION",
            .mghd => "MGHD",
            .mguhd => "MGUHD",
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
