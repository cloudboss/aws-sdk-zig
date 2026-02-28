const AggregatorFilterType = @import("aggregator_filter_type.zig").AggregatorFilterType;

/// An object to filter service-linked configuration recorders in an aggregator
/// based on the linked Amazon Web Services service.
pub const AggregatorFilterServicePrincipal = struct {
    /// The type of service principal filter to apply. `INCLUDE` specifies that the
    /// list of service principals in the `Value` field will be aggregated and no
    /// other service principals will be filtered.
    type: ?AggregatorFilterType,

    /// Comma-separated list of service principals for the linked Amazon Web
    /// Services services to filter your aggregated service-linked configuration
    /// recorders.
    value: ?[]const []const u8,

    pub const json_field_names = .{
        .type = "Type",
        .value = "Value",
    };
};
