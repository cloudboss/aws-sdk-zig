const AggregatorFilterResourceType = @import("aggregator_filter_resource_type.zig").AggregatorFilterResourceType;
const AggregatorFilterServicePrincipal = @import("aggregator_filter_service_principal.zig").AggregatorFilterServicePrincipal;

/// An object to filter the data you specify for an aggregator.
pub const AggregatorFilters = struct {
    /// An object to filter the configuration recorders based on the resource types
    /// in scope for recording.
    resource_type: ?AggregatorFilterResourceType = null,

    /// An object to filter service-linked configuration recorders in an aggregator
    /// based on the linked Amazon Web Services service.
    service_principal: ?AggregatorFilterServicePrincipal = null,

    pub const json_field_names = .{
        .resource_type = "ResourceType",
        .service_principal = "ServicePrincipal",
    };
};
