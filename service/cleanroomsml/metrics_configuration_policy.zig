const NoiseLevelType = @import("noise_level_type.zig").NoiseLevelType;

/// Provides the configuration policy for metrics generation.
pub const MetricsConfigurationPolicy = struct {
    /// The noise level for the generated metrics.
    noise_level: NoiseLevelType,

    pub const json_field_names = .{
        .noise_level = "noiseLevel",
    };
};
