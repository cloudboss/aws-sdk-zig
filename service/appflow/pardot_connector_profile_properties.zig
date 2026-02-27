/// The connector-specific profile properties required when using Salesforce
/// Pardot.
pub const PardotConnectorProfileProperties = struct {
    /// The business unit id of Salesforce Pardot instance.
    business_unit_id: ?[]const u8,

    /// The location of the Salesforce Pardot resource.
    instance_url: ?[]const u8,

    /// Indicates whether the connector profile applies to a sandbox or production
    /// environment.
    is_sandbox_environment: bool = false,

    pub const json_field_names = .{
        .business_unit_id = "businessUnitId",
        .instance_url = "instanceUrl",
        .is_sandbox_environment = "isSandboxEnvironment",
    };
};
