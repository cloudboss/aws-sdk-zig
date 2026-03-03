const std = @import("std");

/// Use Noise reducer filter to select one of the following spatial image
/// filtering functions. To use this setting, you must also enable Noise
/// reducer. * Bilateral preserves edges while reducing noise. * Mean (softest),
/// Gaussian, Lanczos, and Sharpen (sharpest) do convolution filtering. *
/// Conserve does min/max noise reduction. * Spatial does frequency-domain
/// filtering based on JND principles. * Temporal optimizes video quality for
/// complex motion.
pub const NoiseReducerFilter = enum {
    bilateral,
    mean,
    gaussian,
    lanczos,
    sharpen,
    conserve,
    spatial,
    temporal,

    pub const json_field_names = .{
        .bilateral = "BILATERAL",
        .mean = "MEAN",
        .gaussian = "GAUSSIAN",
        .lanczos = "LANCZOS",
        .sharpen = "SHARPEN",
        .conserve = "CONSERVE",
        .spatial = "SPATIAL",
        .temporal = "TEMPORAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bilateral => "BILATERAL",
            .mean => "MEAN",
            .gaussian => "GAUSSIAN",
            .lanczos => "LANCZOS",
            .sharpen => "SHARPEN",
            .conserve => "CONSERVE",
            .spatial => "SPATIAL",
            .temporal => "TEMPORAL",
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
