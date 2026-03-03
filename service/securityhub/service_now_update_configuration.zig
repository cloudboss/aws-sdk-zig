/// The parameters used to modify an existing ServiceNow integration.
pub const ServiceNowUpdateConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Web Services Secrets Manager
    /// secret that contains the ServiceNow credentials.
    secret_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .secret_arn = "SecretArn",
    };
};
