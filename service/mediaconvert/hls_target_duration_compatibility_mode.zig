const std = @import("std");

/// When set to LEGACY, the segment target duration is always rounded up to the
/// nearest integer value above its current value in seconds. When set to
/// SPEC\\_COMPLIANT, the segment target duration is rounded up to the nearest
/// integer value if fraction seconds are greater than or equal to 0.5 (>= 0.5)
/// and rounded down if less than 0.5 (< 0.5). You may need to use LEGACY if
/// your client needs to ensure that the target duration is always longer than
/// the actual duration of the segment. Some older players may experience
/// interrupted playback when the actual duration of a track in a segment is
/// longer than the target duration.
pub const HlsTargetDurationCompatibilityMode = enum {
    legacy,
    spec_compliant,

    pub const json_field_names = .{
        .legacy = "LEGACY",
        .spec_compliant = "SPEC_COMPLIANT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .legacy => "LEGACY",
            .spec_compliant => "SPEC_COMPLIANT",
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
