const AzureScopeConfigurationInput = @import("azure_scope_configuration_input.zig").AzureScopeConfigurationInput;

/// The Azure-specific configuration details for updating a connector, including
/// the scan scope and regions to scan.
pub const AzureProviderDetailUpdate = struct {
    /// Specifies whether to automatically install the VM scanner on connected Azure
    /// resources.
    auto_install_vm_scanner: ?bool = null,

    /// The updated Azure regions to scan.
    azure_regions: ?[]const []const u8 = null,

    /// The updated scope configuration that defines which Azure resources to scan.
    scope_configuration: ?AzureScopeConfigurationInput = null,

    pub const json_field_names = .{
        .auto_install_vm_scanner = "autoInstallVMScanner",
        .azure_regions = "azureRegions",
        .scope_configuration = "scopeConfiguration",
    };
};
