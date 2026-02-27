const FlowTransitEncryption = @import("flow_transit_encryption.zig").FlowTransitEncryption;

/// Configuration settings for connecting a router output to a MediaConnect flow
/// source.
pub const MediaConnectFlowRouterOutputConfiguration = struct {
    /// The encryption configuration for the flow destination when connected to this
    /// router output.
    destination_transit_encryption: FlowTransitEncryption,

    /// The ARN of the flow to connect to this router output.
    flow_arn: ?[]const u8,

    /// The ARN of the flow source to connect to this router output.
    flow_source_arn: ?[]const u8,

    pub const json_field_names = .{
        .destination_transit_encryption = "DestinationTransitEncryption",
        .flow_arn = "FlowArn",
        .flow_source_arn = "FlowSourceArn",
    };
};
