const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterConfiguration = @import("cluster_configuration.zig").ClusterConfiguration;
const DbInstanceType = @import("db_instance_type.zig").DbInstanceType;
const DbStorageType = @import("db_storage_type.zig").DbStorageType;
const ResourceDeploymentType = @import("resource_deployment_type.zig").ResourceDeploymentType;
const EngineType = @import("engine_type.zig").EngineType;
const FailoverMode = @import("failover_mode.zig").FailoverMode;
const LogDeliveryConfiguration = @import("log_delivery_configuration.zig").LogDeliveryConfiguration;
const MaintenanceSchedule = @import("maintenance_schedule.zig").MaintenanceSchedule;
const NetworkType = @import("network_type.zig").NetworkType;
const DbBackupStatus = @import("db_backup_status.zig").DbBackupStatus;
const DbBackupType = @import("db_backup_type.zig").DbBackupType;

pub const DeleteDbBackupInput = struct {
    /// The identifier of the backup to delete.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "identifier",
    };
};

pub const DeleteDbBackupOutput = struct {
    /// The allocated storage of the resource at the time of backup, in GiB.
    allocated_storage: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the deleted backup.
    arn: []const u8,

    /// The cluster configuration of the resource at the time of backup.
    cluster_configuration: ?ClusterConfiguration = null,

    /// The time when the backup was created.
    created_at: ?i64 = null,

    /// The DB instance type of the resource at the time of backup.
    db_instance_type: ?DbInstanceType = null,

    /// The identifier of the DB parameter group associated with the backup.
    db_parameter_group_id: ?[]const u8 = null,

    /// The identifier of the DB resource that the backup was created from.
    db_resource_id: ?[]const u8 = null,

    /// The storage type of the resource at the time of backup.
    db_storage_type: ?DbStorageType = null,

    /// The deployment type of the resource that the backup was created from.
    deployment_type: ?ResourceDeploymentType = null,

    /// The engine type of the resource that the backup was created from.
    engine_type: ?EngineType = null,

    /// The date after which the backup was set to be automatically deleted.
    expires_after: ?[]const u8 = null,

    /// The failover mode of the resource at the time of backup.
    failover_mode: ?FailoverMode = null,

    /// Service-generated unique identifier of the deleted backup.
    id: []const u8,

    /// The ARN of the Secrets Manager secret containing the InfluxDB auth
    /// parameters.
    influx_auth_parameters_secret_arn: ?[]const u8 = null,

    /// The Amazon Web Services KMS key ARN used for encryption of the resource at
    /// the time of backup.
    kms_key_id: ?[]const u8 = null,

    /// The log delivery configuration of the resource at the time of backup.
    log_delivery_configuration: ?LogDeliveryConfiguration = null,

    /// The maintenance schedule of the resource at the time of backup.
    maintenance_schedule: ?MaintenanceSchedule = null,

    /// The customer-provided name of the deleted backup.
    name: ?[]const u8 = null,

    /// The network type of the resource at the time of backup.
    network_type: ?NetworkType = null,

    /// The port number of the resource at the time of backup.
    port: ?i32 = null,

    /// Indicates whether the resource was publicly accessible at the time of
    /// backup.
    publicly_accessible: ?bool = null,

    /// The current status of the backup.
    status: ?DbBackupStatus = null,

    /// The type of backup.
    @"type": ?DbBackupType = null,

    /// The VPC security group IDs associated with the resource at the time of
    /// backup.
    vpc_security_group_ids: ?[]const []const u8 = null,

    /// The VPC subnet IDs associated with the resource at the time of backup.
    vpc_subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .allocated_storage = "allocatedStorage",
        .arn = "arn",
        .cluster_configuration = "clusterConfiguration",
        .created_at = "createdAt",
        .db_instance_type = "dbInstanceType",
        .db_parameter_group_id = "dbParameterGroupId",
        .db_resource_id = "dbResourceId",
        .db_storage_type = "dbStorageType",
        .deployment_type = "deploymentType",
        .engine_type = "engineType",
        .expires_after = "expiresAfter",
        .failover_mode = "failoverMode",
        .id = "id",
        .influx_auth_parameters_secret_arn = "influxAuthParametersSecretArn",
        .kms_key_id = "kmsKeyId",
        .log_delivery_configuration = "logDeliveryConfiguration",
        .maintenance_schedule = "maintenanceSchedule",
        .name = "name",
        .network_type = "networkType",
        .port = "port",
        .publicly_accessible = "publiclyAccessible",
        .status = "status",
        .@"type" = "type",
        .vpc_security_group_ids = "vpcSecurityGroupIds",
        .vpc_subnet_ids = "vpcSubnetIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteDbBackupInput, options: CallOptions) !DeleteDbBackupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteDbBackupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonTimestreamInfluxDB.DeleteDbBackup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteDbBackupOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DeleteDbBackupOutput, body, allocator);
}
