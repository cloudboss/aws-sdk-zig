const ScopeConfigurationInput = @import("scope_configuration_input.zig").ScopeConfigurationInput;

/// The scope of Azure resources to scan, defined separately for VM, container
/// image, and serverless scanning. Provide this when you create or update an
/// Azure connector.
pub const AzureScopeConfigurationInput = struct {
    /// The scope configuration input for container image scanning.
    container_image_scanning: ?ScopeConfigurationInput = null,

    /// The scope configuration input for serverless scanning.
    serverless_scanning: ?ScopeConfigurationInput = null,

    /// The scope configuration input for VM scanning.
    vm_scanning: ?ScopeConfigurationInput = null,

    pub const json_field_names = .{
        .container_image_scanning = "containerImageScanning",
        .serverless_scanning = "serverlessScanning",
        .vm_scanning = "vmScanning",
    };
};
