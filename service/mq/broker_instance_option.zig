const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;
const EngineType = @import("engine_type.zig").EngineType;
const BrokerStorageType = @import("broker_storage_type.zig").BrokerStorageType;
const DeploymentMode = @import("deployment_mode.zig").DeploymentMode;

/// Option for host instance type.
pub const BrokerInstanceOption = struct {
    /// The list of available az.
    availability_zones: ?[]const AvailabilityZone,

    /// The broker's engine type.
    engine_type: ?EngineType,

    /// The broker's instance type.
    host_instance_type: ?[]const u8,

    /// The broker's storage type.
    storage_type: ?BrokerStorageType,

    /// The list of supported deployment modes.
    supported_deployment_modes: ?[]const DeploymentMode,

    /// The list of supported engine versions.
    supported_engine_versions: ?[]const []const u8,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .engine_type = "EngineType",
        .host_instance_type = "HostInstanceType",
        .storage_type = "StorageType",
        .supported_deployment_modes = "SupportedDeploymentModes",
        .supported_engine_versions = "SupportedEngineVersions",
    };
};
