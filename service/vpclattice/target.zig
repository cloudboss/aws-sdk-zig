/// Describes a target.
pub const Target = struct {
    /// The ID of the target. If the target group type is `INSTANCE`, this is an
    /// instance ID. If the target group type is `IP`, this is an IP address. If the
    /// target group type is `LAMBDA`, this is the ARN of a Lambda function. If the
    /// target group type is `ALB`, this is the ARN of an Application Load Balancer.
    id: []const u8,

    /// The port on which the target is listening. For HTTP, the default is 80. For
    /// HTTPS, the default is 443.
    port: ?i32 = null,

    pub const json_field_names = .{
        .id = "id",
        .port = "port",
    };
};
