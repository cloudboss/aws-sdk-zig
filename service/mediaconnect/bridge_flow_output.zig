/// The output of the bridge. A flow output is delivered to the Amazon Web
/// Services cloud.
pub const BridgeFlowOutput = struct {
    /// The Amazon Resource Number (ARN) of the cloud flow.
    flow_arn: []const u8,

    /// The Amazon Resource Number (ARN) of the flow source.
    flow_source_arn: []const u8,

    /// The name of the bridge's output.
    name: []const u8,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
        .flow_source_arn = "FlowSourceArn",
        .name = "Name",
    };
};
