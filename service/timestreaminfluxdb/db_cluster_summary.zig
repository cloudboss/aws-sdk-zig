const DbInstanceType = @import("db_instance_type.zig").DbInstanceType;
const DbStorageType = @import("db_storage_type.zig").DbStorageType;
const ClusterDeploymentType = @import("cluster_deployment_type.zig").ClusterDeploymentType;
const EngineType = @import("engine_type.zig").EngineType;
const NetworkType = @import("network_type.zig").NetworkType;
const ClusterStatus = @import("cluster_status.zig").ClusterStatus;

/// Describes a summary of a Timestream for InfluxDB cluster.
pub const DbClusterSummary = struct {
    /// The amount of storage allocated for your DB storage type (in gibibytes).
    allocated_storage: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the DB cluster.
    arn: []const u8,

    /// The Timestream for InfluxDB DB instance type that InfluxDB runs on.
    db_instance_type: ?DbInstanceType = null,

    /// The Timestream for InfluxDB DB storage type that InfluxDB stores data on.
    db_storage_type: ?DbStorageType = null,

    /// Deployment type of the DB cluster
    deployment_type: ?ClusterDeploymentType = null,

    /// The endpoint used to connect to the Timestream for InfluxDB cluster for
    /// write and read operations.
    endpoint: ?[]const u8 = null,

    /// The engine type of your DB cluster.
    engine_type: ?EngineType = null,

    /// Service-generated unique identifier of the DB cluster to retrieve.
    id: []const u8,

    /// Customer supplied name of the Timestream for InfluxDB cluster.
    name: []const u8,

    /// Specifies whether the network type of the Timestream for InfluxDB Cluster is
    /// IPv4, which can communicate over IPv4 protocol only, or DUAL, which can
    /// communicate over both IPv4 and IPv6 protocols.
    network_type: ?NetworkType = null,

    /// The port number on which InfluxDB accepts connections.
    port: ?i32 = null,

    /// The endpoint used to connect to the Timestream for InfluxDB cluster for
    /// read-only operations.
    reader_endpoint: ?[]const u8 = null,

    /// The status of the DB cluster.
    status: ?ClusterStatus = null,

    pub const json_field_names = .{
        .allocated_storage = "allocatedStorage",
        .arn = "arn",
        .db_instance_type = "dbInstanceType",
        .db_storage_type = "dbStorageType",
        .deployment_type = "deploymentType",
        .endpoint = "endpoint",
        .engine_type = "engineType",
        .id = "id",
        .name = "name",
        .network_type = "networkType",
        .port = "port",
        .reader_endpoint = "readerEndpoint",
        .status = "status",
    };
};
