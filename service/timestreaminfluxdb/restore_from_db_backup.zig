const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DbBackupConfiguration = @import("db_backup_configuration.zig").DbBackupConfiguration;
const ResourceDeploymentType = @import("resource_deployment_type.zig").ResourceDeploymentType;
const LogDeliveryConfiguration = @import("log_delivery_configuration.zig").LogDeliveryConfiguration;
const MaintenanceSchedule = @import("maintenance_schedule.zig").MaintenanceSchedule;
const NetworkType = @import("network_type.zig").NetworkType;
const RestoreMode = @import("restore_mode.zig").RestoreMode;
const EngineType = @import("engine_type.zig").EngineType;
const ResourceType = @import("resource_type.zig").ResourceType;
const RestoreStatus = @import("restore_status.zig").RestoreStatus;

pub const RestoreFromDbBackupInput = struct {
    /// A list of backup configurations to apply to the restored resource.
    db_backup_configurations: ?[]const DbBackupConfiguration = null,

    /// The identifier of the backup to restore from.
    db_backup_id: []const u8,

    /// Specifies the deployment type of the restored resource. Valid values are
    /// SINGLE_AZ, WITH_MULTIAZ_STANDBY, and MULTI_NODE_READ_REPLICAS.
    deployment_type: ?ResourceDeploymentType = null,

    /// The Amazon Web Services KMS key identifier to use for encryption of the
    /// restored resource. Can be a key ID, key ARN, alias name, or alias ARN.
    kms_key_id: ?[]const u8 = null,

    /// Configuration for sending InfluxDB engine logs to the specified S3 bucket
    /// for the restored resource.
    log_delivery_configuration: ?LogDeliveryConfiguration = null,

    /// The maintenance schedule for the restored resource.
    maintenance_schedule: ?MaintenanceSchedule = null,

    /// The name of the new resource to create from the restore. If restoring to an
    /// existing resource, the name must match the existing resource name.
    name: []const u8,

    /// Specifies the network type of the restored resource. Valid values are IPV4
    /// and DUAL.
    network_type: ?NetworkType = null,

    /// The port number on which the restored InfluxDB resource accepts connections.
    port: ?i32 = null,

    /// Specifies whether the restored resource is publicly accessible.
    publicly_accessible: ?bool = null,

    /// Specifies whether to restore to a new resource or replace the existing
    /// resource. Valid values are NEW_RESOURCE (default) and REPLACE_EXISTING.
    restore_mode: ?RestoreMode = null,

    /// The point in time to restore to, for continuous backups. Must be within the
    /// backup's retention window.
    restore_to_time: ?i64 = null,

    /// A list of key-value pairs to associate with the restored resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A list of VPC security group IDs for the restored resource. If not
    /// specified, the restored resource uses the same security groups as the
    /// backup.
    vpc_security_group_ids: ?[]const []const u8 = null,

    /// A list of VPC subnet IDs for the restored resource. If not specified, the
    /// restored resource uses the same subnets as the backup.
    vpc_subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .db_backup_configurations = "dbBackupConfigurations",
        .db_backup_id = "dbBackupId",
        .deployment_type = "deploymentType",
        .kms_key_id = "kmsKeyId",
        .log_delivery_configuration = "logDeliveryConfiguration",
        .maintenance_schedule = "maintenanceSchedule",
        .name = "name",
        .network_type = "networkType",
        .port = "port",
        .publicly_accessible = "publiclyAccessible",
        .restore_mode = "restoreMode",
        .restore_to_time = "restoreToTime",
        .tags = "tags",
        .vpc_security_group_ids = "vpcSecurityGroupIds",
        .vpc_subnet_ids = "vpcSubnetIds",
    };
};

pub const RestoreFromDbBackupOutput = struct {
    /// The deployment type of the restored resource.
    deployment_type: ?ResourceDeploymentType = null,

    /// The engine type of the restored resource.
    engine_type: ?EngineType = null,

    /// The type of the restored resource. Valid values are DB_INSTANCE and
    /// DB_CLUSTER.
    resource_type: ?ResourceType = null,

    /// The identifier of the restored DB resource.
    restored_db_resource_id: ?[]const u8 = null,

    /// The status of the restore operation.
    restore_status: ?RestoreStatus = null,

    pub const json_field_names = .{
        .deployment_type = "deploymentType",
        .engine_type = "engineType",
        .resource_type = "resourceType",
        .restored_db_resource_id = "restoredDbResourceId",
        .restore_status = "restoreStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreFromDbBackupInput, options: CallOptions) !RestoreFromDbBackupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreFromDbBackupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonTimestreamInfluxDB.RestoreFromDbBackup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreFromDbBackupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RestoreFromDbBackupOutput, body, allocator);
}
