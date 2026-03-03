const DbInstanceType = @import("db_instance_type.zig").DbInstanceType;
const DbStorageType = @import("db_storage_type.zig").DbStorageType;
const DeploymentType = @import("deployment_type.zig").DeploymentType;
const NetworkType = @import("network_type.zig").NetworkType;
const Status = @import("status.zig").Status;

/// Contains a summary of a DB instance.
pub const DbInstanceSummary = struct {
    /// The amount of storage to allocate for your DbStorageType in GiB (gibibytes).
    allocated_storage: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the DB instance.
    arn: []const u8,

    /// The Timestream for InfluxDB instance type to run InfluxDB on.
    db_instance_type: ?DbInstanceType = null,

    /// The storage type for your DB instance.
    db_storage_type: ?DbStorageType = null,

    /// Single-Instance or with a MultiAZ Standby for High availability.
    deployment_type: ?DeploymentType = null,

    /// The endpoint used to connect to InfluxDB. The default InfluxDB port is 8086.
    endpoint: ?[]const u8 = null,

    /// The service-generated unique identifier of the DB instance.
    id: []const u8,

    /// This customer-supplied name uniquely identifies the DB instance when
    /// interacting with
    /// the Amazon Timestream for InfluxDB API and CLI commands.
    name: []const u8,

    /// Specifies whether the networkType of the Timestream for InfluxDB instance is
    /// IPV4, which can communicate over IPv4 protocol only, or DUAL, which can
    /// communicate over both IPv4 and IPv6 protocols.
    network_type: ?NetworkType = null,

    /// The port number on which InfluxDB accepts connections.
    port: ?i32 = null,

    /// The status of the DB instance.
    status: ?Status = null,

    pub const json_field_names = .{
        .allocated_storage = "allocatedStorage",
        .arn = "arn",
        .db_instance_type = "dbInstanceType",
        .db_storage_type = "dbStorageType",
        .deployment_type = "deploymentType",
        .endpoint = "endpoint",
        .id = "id",
        .name = "name",
        .network_type = "networkType",
        .port = "port",
        .status = "status",
    };
};
