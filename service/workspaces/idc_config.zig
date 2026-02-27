/// Specifies the configurations of the identity center.
pub const IDCConfig = struct {
    /// The Amazon Resource Name (ARN) of the application.
    application_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the identity center instance.
    instance_arn: ?[]const u8,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .instance_arn = "InstanceArn",
    };
};
