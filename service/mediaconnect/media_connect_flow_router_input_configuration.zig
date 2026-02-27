const FlowTransitEncryption = @import("flow_transit_encryption.zig").FlowTransitEncryption;

/// Configuration settings for connecting a router input to a flow output.
pub const MediaConnectFlowRouterInputConfiguration = struct {
    /// The ARN of the flow to connect to.
    flow_arn: ?[]const u8,

    /// The ARN of the flow output to connect to this router input.
    flow_output_arn: ?[]const u8,

    /// The decryption configuration for the flow source when connected to this
    /// router input.
    source_transit_decryption: FlowTransitEncryption,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
        .flow_output_arn = "FlowOutputArn",
        .source_transit_decryption = "SourceTransitDecryption",
    };
};
