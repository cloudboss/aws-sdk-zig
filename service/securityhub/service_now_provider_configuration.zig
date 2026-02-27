/// The initial configuration settings required to establish an integration
/// between Security Hub and ServiceNow ITSM.
pub const ServiceNowProviderConfiguration = struct {
    /// The instance name of ServiceNow ITSM.
    instance_name: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Secrets Manager
    /// secret that contains the ServiceNow credentials.
    secret_arn: []const u8,

    pub const json_field_names = .{
        .instance_name = "InstanceName",
        .secret_arn = "SecretArn",
    };
};
