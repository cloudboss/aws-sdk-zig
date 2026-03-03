const VpcInterfaceAttachment = @import("vpc_interface_attachment.zig").VpcInterfaceAttachment;

/// Add a flow source to an existing bridge.
pub const AddBridgeFlowSourceRequest = struct {
    /// The Amazon Resource Number (ARN) of the flow to use as a source of this
    /// bridge.
    flow_arn: []const u8,

    /// The name of the VPC interface attachment to use for this source.
    flow_vpc_interface_attachment: ?VpcInterfaceAttachment = null,

    /// The name of the flow source. This name is used to reference the source and
    /// must be unique among sources in this bridge.
    name: []const u8,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
        .flow_vpc_interface_attachment = "FlowVpcInterfaceAttachment",
        .name = "Name",
    };
};
