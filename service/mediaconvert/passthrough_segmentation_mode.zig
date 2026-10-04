const std = @import("std");

/// Choose how MediaConvert determines segment boundaries when you passthrough
/// video to a segmented ABR output (HLS, DASH, or CMAF). This setting applies
/// only to ABR outputs. Keep the default value, Auto, to let MediaConvert
/// choose based on your input: when your input is a segmented HLS or DASH
/// source, MediaConvert reproduces your input's own segment boundaries, with
/// one output segment per input segment; for all other inputs, MediaConvert
/// places boundaries by duration, cutting at the first eligible IDR-frame at or
/// after each configured Segment length or Fragment length target. Choose
/// Duration based to always place boundaries by duration, at the first eligible
/// IDR-frame at or after each configured Segment length or Fragment length
/// target, regardless of your input. When your input GOP duration does not
/// evenly divide your target segment length, output segment durations will
/// vary. Choose GOP count to place a fixed number of input GOPs in every
/// segment, and specify GOPs per segment. Every segment contains the same
/// number of input GOPs, which produces consistent segment durations when your
/// input GOP cadence is constant. In this mode MediaConvert ignores your
/// configured Segment length and Fragment length for video boundary placement.
/// Ad avails and input discontinuities are still honored as segment boundaries.
pub const PassthroughSegmentationMode = enum {
    auto,
    duration_based,
    gop_count,

    pub const json_field_names = .{
        .auto = "AUTO",
        .duration_based = "DURATION_BASED",
        .gop_count = "GOP_COUNT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .duration_based => "DURATION_BASED",
            .gop_count => "GOP_COUNT",
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
