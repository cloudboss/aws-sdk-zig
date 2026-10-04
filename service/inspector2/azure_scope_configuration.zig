const ScopeConfiguration = @import("scope_configuration.zig").ScopeConfiguration;

/// The scope of Azure resources that Amazon Inspector scans, defined separately
/// for VM, container image, and serverless scanning. Returned as part of a
/// connector's configuration.
pub const AzureScopeConfiguration = struct {
    /// The scope configuration for container image scanning.
    container_image_scanning: ?ScopeConfiguration = null,

    /// The scope configuration for serverless scanning.
    serverless_scanning: ?ScopeConfiguration = null,

    /// The scope configuration for VM scanning.
    vm_scanning: ?ScopeConfiguration = null,

    pub const json_field_names = .{
        .container_image_scanning = "containerImageScanning",
        .serverless_scanning = "serverlessScanning",
        .vm_scanning = "vmScanning",
    };
};
