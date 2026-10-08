const EdgePropertySummary = @import("edge_property_summary.zig").EdgePropertySummary;

/// Contains summary information about a service topology edge.
pub const ServiceTopologyEdgeSummary = struct {
    /// The AWS account ID of the destination resource.
    destination_account: ?[]const u8 = null,

    /// The AWS Region of the destination resource.
    destination_region: ?[]const u8 = null,

    /// The identifier of the destination resource.
    destination_resource_identifier: []const u8,

    /// The properties of the topology edge.
    properties: ?[]const EdgePropertySummary = null,

    /// The AWS account ID of the source resource.
    source_account: ?[]const u8 = null,

    /// The AWS Region of the source resource.
    source_region: ?[]const u8 = null,

    /// The identifier of the source resource.
    source_resource_identifier: []const u8,

    pub const json_field_names = .{
        .destination_account = "destinationAccount",
        .destination_region = "destinationRegion",
        .destination_resource_identifier = "destinationResourceIdentifier",
        .properties = "properties",
        .source_account = "sourceAccount",
        .source_region = "sourceRegion",
        .source_resource_identifier = "sourceResourceIdentifier",
    };
};
