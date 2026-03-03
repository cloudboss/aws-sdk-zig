const VpcInterfaceAttachment = @import("vpc_interface_attachment.zig").VpcInterfaceAttachment;

/// Update the flow source of the bridge.
pub const UpdateBridgeFlowSourceRequest = struct {
    /// The Amazon Resource Name (ARN) that identifies the MediaConnect resource
    /// from which to delete tags.
    flow_arn: ?[]const u8 = null,

    /// The name of the VPC interface attachment to use for this source.
    flow_vpc_interface_attachment: ?VpcInterfaceAttachment = null,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
        .flow_vpc_interface_attachment = "FlowVpcInterfaceAttachment",
    };
};
