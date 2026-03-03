const std = @import("std");

/// Smooth Group Audio Only Timecode Control
pub const SmoothGroupAudioOnlyTimecodeControl = enum {
    passthrough,
    use_configured_clock,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .use_configured_clock = "USE_CONFIGURED_CLOCK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .passthrough => "PASSTHROUGH",
            .use_configured_clock => "USE_CONFIGURED_CLOCK",
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
