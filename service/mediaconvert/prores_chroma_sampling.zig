const std = @import("std");

/// This setting applies only to ProRes 4444 and ProRes 4444 XQ outputs that you
/// create from inputs that use 4:4:4 chroma sampling. Set Preserve 4:4:4
/// sampling to allow outputs to also use 4:4:4 chroma sampling. You must
/// specify a value for this setting when your output codec profile supports
/// 4:4:4 chroma sampling. Related Settings: For Apple ProRes outputs with 4:4:4
/// chroma sampling: Choose Preserve 4:4:4 sampling. Use when your input has
/// 4:4:4 chroma sampling and your output codec Profile is Apple ProRes 4444 or
/// 4444 XQ. Note that when you choose Preserve 4:4:4 sampling, you cannot
/// include any of the following Preprocessors: Dolby Vision, HDR10+, or Noise
/// reducer.
pub const ProresChromaSampling = enum {
    preserve_444_sampling,
    subsample_to_422,

    pub const json_field_names = .{
        .preserve_444_sampling = "PRESERVE_444_SAMPLING",
        .subsample_to_422 = "SUBSAMPLE_TO_422",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .preserve_444_sampling => "PRESERVE_444_SAMPLING",
            .subsample_to_422 => "SUBSAMPLE_TO_422",
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
