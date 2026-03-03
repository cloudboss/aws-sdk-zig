/// Specifies the configurations of the identity center.
pub const IDCConfig = struct {
    /// The Amazon Resource Name (ARN) of the application.
    application_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the identity center instance.
    instance_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .instance_arn = "InstanceArn",
    };
};
