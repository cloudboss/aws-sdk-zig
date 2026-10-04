const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterConfiguration = @import("cluster_configuration.zig").ClusterConfiguration;
const DbInstanceType = @import("db_instance_type.zig").DbInstanceType;
const DbStorageType = @import("db_storage_type.zig").DbStorageType;
const ClusterDeploymentType = @import("cluster_deployment_type.zig").ClusterDeploymentType;
const EngineType = @import("engine_type.zig").EngineType;
const FailoverMode = @import("failover_mode.zig").FailoverMode;
const LogDeliveryConfiguration = @import("log_delivery_configuration.zig").LogDeliveryConfiguration;
const MaintenanceSchedule = @import("maintenance_schedule.zig").MaintenanceSchedule;
const NetworkType = @import("network_type.zig").NetworkType;
const ClusterStatus = @import("cluster_status.zig").ClusterStatus;

pub const GetDbClusterInput = struct {
    /// Service-generated unique identifier of the DB cluster to retrieve.
    db_cluster_id: []const u8,

    pub const json_field_names = .{
        .db_cluster_id = "dbClusterId",
    };
};

pub const GetDbClusterOutput = struct {
    /// The amount of storage allocated for your DB storage type (in gibibytes).
    allocated_storage: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the DB cluster.
    arn: []const u8,

    /// Configuration for node modes in the DbCluster.
    cluster_configuration: ?ClusterConfiguration = null,

    /// The Timestream for InfluxDB instance type that InfluxDB runs on.
    db_instance_type: ?DbInstanceType = null,

    /// The ID of the DB parameter group assigned to your DB cluster.
    db_parameter_group_identifier: ?[]const u8 = null,

    /// The Timestream for InfluxDB DB storage type that InfluxDB stores data on.
    db_storage_type: ?DbStorageType = null,

    /// Deployment type of the DB cluster.
    deployment_type: ?ClusterDeploymentType = null,

    /// The endpoint used to connect to the Timestream for InfluxDB cluster for
    /// write and read operations.
    endpoint: ?[]const u8 = null,

    /// The engine type of your DB cluster.
    engine_type: ?EngineType = null,

    /// The configured failover mode for the DB cluster.
    failover_mode: ?FailoverMode = null,

    /// Service-generated unique identifier of the DB cluster to retrieve.
    id: []const u8,

    /// The Amazon Resource Name (ARN) of the Secrets Manager secret containing the
    /// initial InfluxDB authorization parameters. The secret value is a JSON
    /// formatted key-value pair holding InfluxDB authorization values:
    /// organization, bucket, username, and password.
    influx_auth_parameters_secret_arn: ?[]const u8 = null,

    /// The timestamp of the last completed maintenance operation on the DB cluster.
    last_maintenance_time: ?i64 = null,

    /// Configuration for sending InfluxDB engine logs to send to specified S3
    /// bucket.
    log_delivery_configuration: ?LogDeliveryConfiguration = null,

    /// The maintenance schedule for the DB cluster.
    maintenance_schedule: ?MaintenanceSchedule = null,

    /// Customer-supplied name of the Timestream for InfluxDB cluster.
    name: []const u8,

    /// Specifies whether the network type of the Timestream for InfluxDB cluster is
    /// IPv4, which can communicate over IPv4 protocol only, or DUAL, which can
    /// communicate over both IPv4 and IPv6 protocols.
    network_type: ?NetworkType = null,

    /// The timestamp of the next scheduled maintenance operation on the DB cluster.
    next_maintenance_time: ?i64 = null,

    /// The port number on which InfluxDB accepts connections.
    port: ?i32 = null,

    /// Indicates if the DB cluster has a public IP to facilitate access from
    /// outside the VPC.
    publicly_accessible: ?bool = null,

    /// The endpoint used to connect to the Timestream for InfluxDB cluster for
    /// read-only operations.
    reader_endpoint: ?[]const u8 = null,

    /// The status of the DB cluster.
    status: ?ClusterStatus = null,

    /// A list of VPC security group IDs associated with the DB cluster.
    vpc_security_group_ids: ?[]const []const u8 = null,

    /// A list of VPC subnet IDs associated with the DB cluster.
    vpc_subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .allocated_storage = "allocatedStorage",
        .arn = "arn",
        .cluster_configuration = "clusterConfiguration",
        .db_instance_type = "dbInstanceType",
        .db_parameter_group_identifier = "dbParameterGroupIdentifier",
        .db_storage_type = "dbStorageType",
        .deployment_type = "deploymentType",
        .endpoint = "endpoint",
        .engine_type = "engineType",
        .failover_mode = "failoverMode",
        .id = "id",
        .influx_auth_parameters_secret_arn = "influxAuthParametersSecretArn",
        .last_maintenance_time = "lastMaintenanceTime",
        .log_delivery_configuration = "logDeliveryConfiguration",
        .maintenance_schedule = "maintenanceSchedule",
        .name = "name",
        .network_type = "networkType",
        .next_maintenance_time = "nextMaintenanceTime",
        .port = "port",
        .publicly_accessible = "publiclyAccessible",
        .reader_endpoint = "readerEndpoint",
        .status = "status",
        .vpc_security_group_ids = "vpcSecurityGroupIds",
        .vpc_subnet_ids = "vpcSubnetIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDbClusterInput, options: CallOptions) !GetDbClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "timestream-influxdb", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetDbClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("timestream-influxdb", "Timestream InfluxDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonTimestreamInfluxDB.GetDbCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDbClusterOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetDbClusterOutput, body, allocator);
}
