const VpcInterfaceAttachment = @import("vpc_interface_attachment.zig").VpcInterfaceAttachment;

/// The source configuration for cloud flows receiving a stream from a bridge.
pub const UpdateGatewayBridgeSourceRequest = struct {
    /// The ARN of the bridge feeding this flow.
    bridge_arn: ?[]const u8,

    /// The name of the VPC interface attachment to use for this bridge source.
    vpc_interface_attachment: ?VpcInterfaceAttachment,

    pub const json_field_names = .{
        .bridge_arn = "BridgeArn",
        .vpc_interface_attachment = "VpcInterfaceAttachment",
    };
};
