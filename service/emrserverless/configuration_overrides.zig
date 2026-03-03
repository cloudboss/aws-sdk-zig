const Configuration = @import("configuration.zig").Configuration;
const DiskEncryptionConfiguration = @import("disk_encryption_configuration.zig").DiskEncryptionConfiguration;
const MonitoringConfiguration = @import("monitoring_configuration.zig").MonitoringConfiguration;

/// A configuration specification to be used to override existing
/// configurations.
pub const ConfigurationOverrides = struct {
    /// The override configurations for the application.
    application_configuration: ?[]const Configuration = null,

    /// The override configuration to encrypt local disks.
    disk_encryption_configuration: ?DiskEncryptionConfiguration = null,

    /// The override configurations for monitoring.
    monitoring_configuration: ?MonitoringConfiguration = null,

    pub const json_field_names = .{
        .application_configuration = "applicationConfiguration",
        .disk_encryption_configuration = "diskEncryptionConfiguration",
        .monitoring_configuration = "monitoringConfiguration",
    };
};
