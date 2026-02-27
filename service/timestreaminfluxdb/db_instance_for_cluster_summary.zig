const DbInstanceType = @import("db_instance_type.zig").DbInstanceType;
const DbStorageType = @import("db_storage_type.zig").DbStorageType;
const DeploymentType = @import("deployment_type.zig").DeploymentType;
const InstanceMode = @import("instance_mode.zig").InstanceMode;
const NetworkType = @import("network_type.zig").NetworkType;
const Status = @import("status.zig").Status;

/// Contains a summary of a DB instance belonging to a DB cluster.
pub const DbInstanceForClusterSummary = struct {
    /// The amount of storage allocated for your DB storage type in GiB (gibibytes).
    allocated_storage: ?i32,

    /// The Amazon Resource Name (ARN) of the DB instance.
    arn: []const u8,

    /// The Timestream for InfluxDB instance type to run InfluxDB on.
    db_instance_type: ?DbInstanceType,

    /// The storage type for your DB instance.
    db_storage_type: ?DbStorageType,

    /// Specifies the deployment type if applicable.
    deployment_type: ?DeploymentType,

    /// The endpoint used to connect to InfluxDB. The default InfluxDB port is 8086.
    endpoint: ?[]const u8,

    /// The service-generated unique identifier of the DB instance.
    id: []const u8,

    /// Specifies the DB instance's role in the cluster.
    instance_mode: ?InstanceMode,

    /// Specifies the DB instance's roles in the cluster.
    instance_modes: ?[]const InstanceMode,

    /// A service-generated name for the DB instance based on the customer-supplied
    /// name for the DB cluster.
    name: []const u8,

    /// Specifies whether the network type of the Timestream for InfluxDB instance
    /// is IPv4, which can communicate over IPv4 protocol only, or DUAL, which can
    /// communicate over both IPv4 and IPv6 protocols.
    network_type: ?NetworkType,

    /// The port number on which InfluxDB accepts connections.
    port: ?i32,

    /// The status of the DB instance.
    status: ?Status,

    pub const json_field_names = .{
        .allocated_storage = "allocatedStorage",
        .arn = "arn",
        .db_instance_type = "dbInstanceType",
        .db_storage_type = "dbStorageType",
        .deployment_type = "deploymentType",
        .endpoint = "endpoint",
        .id = "id",
        .instance_mode = "instanceMode",
        .instance_modes = "instanceModes",
        .name = "name",
        .network_type = "networkType",
        .port = "port",
        .status = "status",
    };
};
