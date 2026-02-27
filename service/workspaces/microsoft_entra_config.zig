/// Specifies the configurations of the Microsoft Entra.
pub const MicrosoftEntraConfig = struct {
    /// The Amazon Resource Name (ARN) of the application config.
    application_config_secret_arn: ?[]const u8,

    /// The identifier of the tenant.
    tenant_id: ?[]const u8,

    pub const json_field_names = .{
        .application_config_secret_arn = "ApplicationConfigSecretArn",
        .tenant_id = "TenantId",
    };
};
