const std = @import("std");

/// Specify whether to pass SMPTE 337M-wrapped audio (such as Dolby E) through
/// without unwrapping. Choose Enabled to pass the SMPTE 337M container through
/// unchanged, treating the track as raw PCM. Choose Disabled (default) to
/// automatically detect and unwrap SMPTE 337M data, extracting the underlying
/// Dolby E programs as separate audio tracks for encoding. When this field is
/// absent, the service defaults to Disabled (auto-unwrap).
pub const AudioSmpte337Passthrough = enum {
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
