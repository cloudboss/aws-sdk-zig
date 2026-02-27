const ExecuteCommandConfiguration = @import("execute_command_configuration.zig").ExecuteCommandConfiguration;
const ManagedStorageConfiguration = @import("managed_storage_configuration.zig").ManagedStorageConfiguration;

/// The execute command and managed storage configuration for the cluster.
pub const ClusterConfiguration = struct {
    /// The details of the execute command configuration.
    execute_command_configuration: ?ExecuteCommandConfiguration,

    /// The details of the managed storage configuration.
    managed_storage_configuration: ?ManagedStorageConfiguration,

    pub const json_field_names = .{
        .execute_command_configuration = "executeCommandConfiguration",
        .managed_storage_configuration = "managedStorageConfiguration",
    };
};
