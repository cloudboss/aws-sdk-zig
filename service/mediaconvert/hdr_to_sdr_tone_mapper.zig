const std = @import("std");

/// Specify how MediaConvert maps brightness and colors from your HDR input to
/// your SDR output. The mode that you select represents a creative choice, with
/// different tradeoffs in the details and tones of your output. To maintain
/// details in bright or saturated areas of your output: Choose Preserve
/// details. For some sources, your SDR output may look less bright and less
/// saturated when compared to your HDR source. MediaConvert automatically
/// applies this mode for HLG sources, regardless of your choice. For a bright
/// and saturated output: Choose Vibrant. We recommend that you choose this mode
/// when any of your source content is HDR10, and for the best results when it
/// is mastered for 1000 nits. You may notice loss of details in bright or
/// saturated areas of your output. HDR to SDR tone mapping has no effect when
/// your input is SDR.
pub const HDRToSDRToneMapper = enum {
    preserve_details,
    vibrant,

    pub const json_field_names = .{
        .preserve_details = "PRESERVE_DETAILS",
        .vibrant = "VIBRANT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .preserve_details => "PRESERVE_DETAILS",
            .vibrant => "VIBRANT",
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
