/// VPC connection properties.
pub const VpcConnectionProperties = struct {
    /// The Amazon Resource Name (ARN) for the VPC connection.
    vpc_connection_arn: []const u8,

    pub const json_field_names = .{
        .vpc_connection_arn = "VpcConnectionArn",
    };
};
