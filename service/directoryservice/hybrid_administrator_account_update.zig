/// Use to recover to the hybrid directory administrator account credentials.
pub const HybridAdministratorAccountUpdate = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Web Services Secrets Manager
    /// secret that contains the
    /// credentials for the AD administrator user, and enables hybrid domain
    /// controllers to
    /// join the managed AD domain. For example:
    ///
    /// `
    /// {"customerAdAdminDomainUsername":"carlos_salazar","customerAdAdminDomainPassword":"ExamplePassword123!"}.
    /// `
    secret_arn: []const u8,

    pub const json_field_names = .{
        .secret_arn = "SecretArn",
    };
};
