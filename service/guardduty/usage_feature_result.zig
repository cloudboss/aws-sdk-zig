const UsageFeature = @import("usage_feature.zig").UsageFeature;
const Total = @import("total.zig").Total;

/// Contains information about the result of the total usage based on the
/// feature.
pub const UsageFeatureResult = struct {
    /// The feature that generated the usage cost.
    feature: ?UsageFeature,

    total: ?Total,

    pub const json_field_names = .{
        .feature = "Feature",
        .total = "Total",
    };
};
