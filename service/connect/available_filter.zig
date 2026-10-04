const AvailableFilterType = @import("available_filter_type.zig").AvailableFilterType;

/// A filter that is available for use with the metric. Part of an
/// AvailableFilterList that describes the filters that are available for use
/// with the metric.
pub const AvailableFilter = struct {
    /// The identifier of the filter.
    id: ?[]const u8 = null,

    /// The type of the filter. Valid values: `METRIC_LEVEL` | `RESOURCE_LEVEL`.
    @"type": ?AvailableFilterType = null,

    pub const json_field_names = .{
        .id = "Id",
        .@"type" = "Type",
    };
};
