const ResourceSpec = @import("resource_spec.zig").ResourceSpec;

/// A collection of settings that update the current configuration for the
/// `RStudioServerPro` Domain-level app.
pub const RStudioServerProDomainSettingsForUpdate = struct {
    default_resource_spec: ?ResourceSpec = null,

    /// The execution role for the `RStudioServerPro` Domain-level app.
    domain_execution_role_arn: []const u8,

    /// A URL pointing to an RStudio Connect server.
    r_studio_connect_url: ?[]const u8 = null,

    /// A URL pointing to an RStudio Package Manager server.
    r_studio_package_manager_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_resource_spec = "DefaultResourceSpec",
        .domain_execution_role_arn = "DomainExecutionRoleArn",
        .r_studio_connect_url = "RStudioConnectUrl",
        .r_studio_package_manager_url = "RStudioPackageManagerUrl",
    };
};
