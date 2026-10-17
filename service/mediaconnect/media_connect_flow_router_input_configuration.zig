const FlowTransitEncryption = @import("flow_transit_encryption.zig").FlowTransitEncryption;

/// Configuration settings for connecting a router input to a flow output.
///
/// To connect the router input to the flow output, provide both `flowArn` and
/// `flowOutputArn`. To disconnect it, call the update operation and omit both
/// fields while keeping this configuration object.
///
/// You can't change `sourceTransitDecryption` while the router input is
/// connected to a flow output. To change it, first disconnect the router input,
/// then update the decryption.
pub const MediaConnectFlowRouterInputConfiguration = struct {
    /// The ARN of the flow to connect to.
    flow_arn: ?[]const u8 = null,

    /// The ARN of the flow output to connect to this router input.
    flow_output_arn: ?[]const u8 = null,

    /// The decryption configuration for the flow source when connected to this
    /// router input.
    source_transit_decryption: FlowTransitEncryption,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
        .flow_output_arn = "FlowOutputArn",
        .source_transit_decryption = "SourceTransitDecryption",
    };
};
