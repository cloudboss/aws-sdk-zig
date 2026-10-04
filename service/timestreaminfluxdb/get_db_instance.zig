const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DbBackupConfigurationOutput = @import("db_backup_configuration_output.zig").DbBackupConfigurationOutput;
const DbInstanceType = @import("db_instance_type.zig").DbInstanceType;
const DbStorageType = @import("db_storage_type.zig").DbStorageType;
const DeploymentType = @import("deployment_type.zig").DeploymentType;
const InstanceMode = @import("instance_mode.zig").InstanceMode;
const LogDeliveryConfiguration = @import("log_delivery_configuration.zig").LogDeliveryConfiguration;
const MaintenanceSchedule = @import("maintenance_schedule.zig").MaintenanceSchedule;
const NetworkType = @import("network_type.zig").NetworkType;
const Status = @import("status.zig").Status;

pub const GetDbInstanceInput = struct {
    /// The id of the DB instance.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "identifier",
    };
};

pub const GetDbInstanceOutput = struct {
    /// The amount of storage allocated for your DB storage type (in gibibytes).
    allocated_storage: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the DB instance.
    arn: []const u8,

    /// The Availability Zone in which the DB instance resides.
    availability_zone: ?[]const u8 = null,

    /// The backup configurations for the DB instance.
    db_backup_configurations: ?[]const DbBackupConfigurationOutput = null,

    /// Specifies the DbCluster to which this DbInstance belongs to.
    db_cluster_id: ?[]const u8 = null,

    /// The Timestream for InfluxDB instance type that InfluxDB runs on.
    db_instance_type: ?DbInstanceType = null,

    /// The id of the DB parameter group assigned to your DB instance.
    db_parameter_group_identifier: ?[]const u8 = null,

    /// The Timestream for InfluxDB DB storage type that InfluxDB stores data on.
    db_storage_type: ?DbStorageType = null,

    /// Specifies whether the Timestream for InfluxDB is deployed as Single-AZ or
    /// with a MultiAZ Standby for High availability.
    deployment_type: ?DeploymentType = null,

    /// The endpoint used to connect to InfluxDB. The default InfluxDB port is 8086.
    endpoint: ?[]const u8 = null,

    /// A service-generated unique identifier.
    id: []const u8,

    /// The Amazon Resource Name (ARN) of the Secrets Manager secret containing the
    /// initial InfluxDB authorization parameters. The secret value is a JSON
    /// formatted key-value pair holding InfluxDB authorization values:
    /// organization, bucket, username, and password.
    influx_auth_parameters_secret_arn: ?[]const u8 = null,

    /// Specifies the DbInstance's role in the cluster.
    instance_mode: ?InstanceMode = null,

    /// Specifies the DbInstance's roles in the cluster.
    instance_modes: ?[]const InstanceMode = null,

    /// The Amazon Web Services KMS key ARN used for encryption of the DB instance.
    kms_key_id: ?[]const u8 = null,

    /// The timestamp of the last completed maintenance operation on the DB
    /// instance.
    last_maintenance_time: ?i64 = null,

    /// Configuration for sending InfluxDB engine logs to send to specified S3
    /// bucket.
    log_delivery_configuration: ?LogDeliveryConfiguration = null,

    /// The maintenance schedule for the DB instance.
    maintenance_schedule: ?MaintenanceSchedule = null,

    /// The customer-supplied name that uniquely identifies the DB instance when
    /// interacting with the Amazon Timestream for InfluxDB API and CLI commands.
    name: []const u8,

    /// Specifies whether the networkType of the Timestream for InfluxDB instance is
    /// IPV4, which can communicate over IPv4 protocol only, or DUAL, which can
    /// communicate over both IPv4 and IPv6 protocols.
    network_type: ?NetworkType = null,

    /// The timestamp of the next scheduled maintenance operation on the DB
    /// instance.
    next_maintenance_time: ?i64 = null,

    /// The port number on which InfluxDB accepts connections.
    port: ?i32 = null,

    /// Indicates if the DB instance has a public IP to facilitate access.
    publicly_accessible: ?bool = null,

    /// The Availability Zone in which the standby instance is located when
    /// deploying with a MultiAZ standby instance.
    secondary_availability_zone: ?[]const u8 = null,

    /// The status of the DB instance.
    status: ?Status = null,

    /// A list of VPC security group IDs associated with the DB instance.
    vpc_security_group_ids: ?[]const []const u8 = null,

    /// A list of VPC subnet IDs associated with the DB instance.
    vpc_subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .allocated_storage = "allocatedStorage",
        .arn = "arn",
        .availability_zone = "availabilityZone",
        .db_backup_configurations = "dbBackupConfigurations",
        .db_cluster_id = "dbClusterId",
        .db_instance_type = "dbInstanceType",
        .db_parameter_group_identifier = "dbParameterGroupIdentifier",
        .db_storage_type = "dbStorageType",
        .deployment_type = "deploymentType",
        .endpoint = "endpoint",
        .id = "id",
        .influx_auth_parameters_secret_arn = "influxAuthParametersSecretArn",
        .instance_mode = "instanceMode",
        .instance_modes = "instanceModes",
        .kms_key_id = "kmsKeyId",
        .last_maintenance_time = "lastMaintenanceTime",
        .log_delivery_configuration = "logDeliveryConfiguration",
        .maintenance_schedule = "maintenanceSchedule",
        .name = "name",
        .network_type = "networkType",
        .next_maintenance_time = "nextMaintenanceTime",
        .port = "port",
        .publicly_accessible = "publiclyAccessible",
        .secondary_availability_zone = "secondaryAvailabilityZone",
        .status = "status",
        .vpc_security_group_ids = "vpcSecurityGroupIds",
        .vpc_subnet_ids = "vpcSubnetIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDbInstanceInput, options: CallOptions) !GetDbInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDbInstanceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonTimestreamInfluxDB.GetDbInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDbInstanceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetDbInstanceOutput, body, allocator);
}
