const InsightImpactGraphEdge = @import("insight_impact_graph_edge.zig").InsightImpactGraphEdge;

/// Information about an application that processed requests, users that made
/// requests, or downstream services,
/// resources, and applications that an application used.
pub const InsightImpactGraphService = struct {
    /// Identifier of the Amazon Web Services account in which the service runs.
    account_id: ?[]const u8 = null,

    /// Connections to downstream services.
    edges: ?[]const InsightImpactGraphEdge = null,

    /// The canonical name of the service.
    name: ?[]const u8 = null,

    /// A list of names for the service, including the canonical name.
    names: ?[]const []const u8 = null,

    /// Identifier for the service. Unique within the service map.
    reference_id: ?i32 = null,

    /// Identifier for the service. Unique within the service map.
    ///
    /// * Amazon Web Services Resource - The type of an Amazon Web Services
    ///   resource. For example, AWS::EC2::Instance for an application running
    /// on Amazon EC2 or AWS::DynamoDB::Table for an Amazon DynamoDB table that the
    /// application used.
    ///
    /// * Amazon Web Services Service - The type of an Amazon Web Services service.
    ///   For example, AWS::DynamoDB for downstream calls to Amazon
    /// DynamoDB that didn't target a specific table.
    ///
    /// * Amazon Web Services Service - The type of an Amazon Web Services service.
    ///   For example, AWS::DynamoDB for downstream calls to Amazon
    /// DynamoDB that didn't target a specific table.
    ///
    /// * remote - A downstream service of indeterminate type.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .edges = "Edges",
        .name = "Name",
        .names = "Names",
        .reference_id = "ReferenceId",
        .@"type" = "Type",
    };
};
