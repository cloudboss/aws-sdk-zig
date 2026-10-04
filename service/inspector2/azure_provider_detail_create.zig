const AzureScopeConfigurationInput = @import("azure_scope_configuration_input.zig").AzureScopeConfigurationInput;

/// The Azure-specific configuration details for creating a connector, including
/// the Amazon Web Services Config connector association, scan scope, and
/// regions to scan.
pub const AzureProviderDetailCreate = struct {
    /// Specifies whether to automatically install the VM scanner on connected Azure
    /// resources. Defaults to `true`.
    auto_install_vm_scanner: bool = true,

    /// The ARN of the Amazon Web Services Config connector to associate with this
    /// connector.
    aws_config_connector_arn: []const u8,

    /// The Azure regions to scan.
    azure_regions: []const []const u8,

    /// The scope configuration that defines which Azure resources to scan.
    scope_configuration: AzureScopeConfigurationInput,

    pub const json_field_names = .{
        .auto_install_vm_scanner = "autoInstallVMScanner",
        .aws_config_connector_arn = "awsConfigConnectorArn",
        .azure_regions = "azureRegions",
        .scope_configuration = "scopeConfiguration",
    };
};
