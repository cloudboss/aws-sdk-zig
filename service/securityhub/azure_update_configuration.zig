const AzureScopeConfiguration = @import("azure_scope_configuration.zig").AzureScopeConfiguration;

/// The configuration for updating an Azure connector's scope and regions.
pub const AzureUpdateConfiguration = struct {
    /// The updated list of Azure regions to monitor.
    azure_regions: []const []const u8,

    /// The updated scope configuration.
    scope_configuration: AzureScopeConfiguration,

    pub const json_field_names = .{
        .azure_regions = "AzureRegions",
        .scope_configuration = "ScopeConfiguration",
    };
};
