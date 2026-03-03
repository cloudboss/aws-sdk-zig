/// Configuration for an Amazon EC2 Auto Scaling group used in a Region switch
/// plan.
pub const Asg = struct {
    /// The Amazon Resource Name (ARN) of the EC2 Auto Scaling group.
    arn: ?[]const u8 = null,

    /// The cross account role for the configuration.
    cross_account_role: ?[]const u8 = null,

    /// The external ID (secret key) for the configuration.
    external_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .cross_account_role = "crossAccountRole",
        .external_id = "externalId",
    };
};
