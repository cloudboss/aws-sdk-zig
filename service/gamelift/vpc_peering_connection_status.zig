/// Represents status information for a VPC peering connection. Status codes and
/// messages
/// are provided from EC2 (see
/// [VpcPeeringConnectionStateReason](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_VpcPeeringConnectionStateReason.html)). Connection status information is also
/// communicated as a fleet event.
pub const VpcPeeringConnectionStatus = struct {
    /// Code indicating the status of a VPC peering connection.
    code: ?[]const u8,

    /// Additional messaging associated with the connection status.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
