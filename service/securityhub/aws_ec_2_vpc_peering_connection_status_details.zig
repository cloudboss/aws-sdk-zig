/// Details about the status of the VPC peering connection.
pub const AwsEc2VpcPeeringConnectionStatusDetails = struct {
    /// The status of the VPC peering connection.
    code: ?[]const u8,

    /// A message that provides more information about the status, if applicable.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
