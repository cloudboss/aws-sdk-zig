const FlowTransitEncryption = @import("flow_transit_encryption.zig").FlowTransitEncryption;

/// Configuration settings for connecting a router output to a MediaConnect flow
/// source.
///
/// To connect the router output to the flow source, provide both `flowArn` and
/// `flowSourceArn`. To disconnect it, call the update operation and omit both
/// fields while keeping this configuration object.
///
/// You can't change `destinationTransitEncryption` while the router output is
/// connected to a flow source. To change it, first disconnect the router
/// output, then update the encryption.
pub const MediaConnectFlowRouterOutputConfiguration = struct {
    /// The encryption configuration for the flow destination when connected to this
    /// router output.
    destination_transit_encryption: FlowTransitEncryption,

    /// The ARN of the flow to connect to this router output.
    flow_arn: ?[]const u8 = null,

    /// The ARN of the flow source to connect to this router output.
    flow_source_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_transit_encryption = "DestinationTransitEncryption",
        .flow_arn = "FlowArn",
        .flow_source_arn = "FlowSourceArn",
    };
};
