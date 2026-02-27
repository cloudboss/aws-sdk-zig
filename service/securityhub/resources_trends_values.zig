const ResourcesCount = @import("resources_count.zig").ResourcesCount;

/// Contains the aggregated resource count values for a specific point in the
/// resources trend timeline.
pub const ResourcesTrendsValues = struct {
    /// The resource count statistics for this data point in the trend timeline.
    resources_count: ResourcesCount,

    pub const json_field_names = .{
        .resources_count = "ResourcesCount",
    };
};
