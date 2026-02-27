const VpcInterfaceAttachment = @import("vpc_interface_attachment.zig").VpcInterfaceAttachment;

/// The source of the bridge. A flow source originates in MediaConnect as an
/// existing cloud flow.
pub const BridgeFlowSource = struct {
    /// The ARN of the cloud flow used as a source of this bridge.
    flow_arn: []const u8,

    /// The name of the VPC interface attachment to use for this source.
    flow_vpc_interface_attachment: ?VpcInterfaceAttachment,

    /// The name of the flow source.
    name: []const u8,

    /// The Amazon Resource Number (ARN) of the output.
    output_arn: ?[]const u8,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
        .flow_vpc_interface_attachment = "FlowVpcInterfaceAttachment",
        .name = "Name",
        .output_arn = "OutputArn",
    };
};
