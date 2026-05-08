const StaticOverride = @import("static_override.zig").StaticOverride;
const WeightedOverride = @import("weighted_override.zig").WeightedOverride;

/// An action that applies a configuration bundle override, either as a static
/// override or a weighted split for A/B testing.
pub const ConfigurationBundleAction = union(enum) {
    /// A static configuration bundle override that applies a single bundle version
    /// to all matching requests.
    static_override: ?StaticOverride,
    /// A weighted configuration bundle override that splits traffic between
    /// multiple bundle versions based on configured weights.
    weighted_override: ?WeightedOverride,

    pub const json_field_names = .{
        .static_override = "staticOverride",
        .weighted_override = "weightedOverride",
    };
};
