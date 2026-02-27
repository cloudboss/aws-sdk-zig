const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DbInstanceType = @import("db_instance_type.zig").DbInstanceType;
const DbStorageType = @import("db_storage_type.zig").DbStorageType;
const DeploymentType = @import("deployment_type.zig").DeploymentType;
const LogDeliveryConfiguration = @import("log_delivery_configuration.zig").LogDeliveryConfiguration;
const NetworkType = @import("network_type.zig").NetworkType;
const InstanceMode = @import("instance_mode.zig").InstanceMode;
const Status = @import("status.zig").Status;

pub const CreateDbInstanceInput = struct {
    /// The amount of storage to allocate for your DB storage type in GiB
    /// (gibibytes).
    allocated_storage: i32,

    /// The name of the initial InfluxDB bucket. All InfluxDB data is stored in a
    /// bucket. A bucket combines the concept of a database and a retention period
    /// (the duration of time that each data point persists). A bucket belongs to an
    /// organization.
    bucket: ?[]const u8 = null,

    /// The Timestream for InfluxDB DB instance type to run InfluxDB on.
    db_instance_type: DbInstanceType,

    /// The id of the DB parameter group to assign to your DB instance. DB parameter
    /// groups specify how the database is configured. For example, DB parameter
    /// groups can specify the limit for query concurrency.
    db_parameter_group_identifier: ?[]const u8 = null,

    /// The Timestream for InfluxDB DB storage type to read and write InfluxDB data.
    ///
    /// You can choose between 3 different types of provisioned Influx IOPS included
    /// storage according to your workloads requirements:
    ///
    /// * Influx IO Included 3000 IOPS
    ///
    /// * Influx IO Included 12000 IOPS
    ///
    /// * Influx IO Included 16000 IOPS
    db_storage_type: ?DbStorageType = null,

    /// Specifies whether the DB instance will be deployed as a standalone instance
    /// or with a Multi-AZ standby for high availability.
    deployment_type: ?DeploymentType = null,

    /// Configuration for sending InfluxDB engine logs to a specified S3 bucket.
    log_delivery_configuration: ?LogDeliveryConfiguration = null,

    /// The name that uniquely identifies the DB instance when interacting with the
    /// Amazon Timestream for InfluxDB API and CLI commands. This name will also be
    /// a prefix included in the endpoint. DB instance names must be unique per
    /// customer and per region.
    name: []const u8,

    /// Specifies whether the networkType of the Timestream for InfluxDB instance is
    /// IPV4, which can communicate over IPv4 protocol only, or DUAL, which can
    /// communicate over both IPv4 and IPv6 protocols.
    network_type: ?NetworkType = null,

    /// The name of the initial organization for the initial admin user in InfluxDB.
    /// An InfluxDB organization is a workspace for a group of users.
    organization: ?[]const u8 = null,

    /// The password of the initial admin user created in InfluxDB v2. This password
    /// will allow
    /// you to access the InfluxDB UI to perform various administrative tasks and
    /// also use the
    /// InfluxDB CLI to create an operator token. These attributes will be stored in
    /// a Secret
    /// created in Secrets Manager in your account.
    password: []const u8,

    /// The port number on which InfluxDB accepts connections.
    ///
    /// Valid Values: 1024-65535
    ///
    /// Default: 8086
    ///
    /// Constraints: The value can't be 2375-2376, 7788-7799, 8090, or 51678-51680
    port: i32 = 8086,

    /// Configures the DB instance with a public IP to facilitate access.
    publicly_accessible: ?bool = null,

    /// A list of key-value pairs to associate with the DB instance.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The username of the initial admin user created in InfluxDB. Must start with
    /// a letter and can't end with a hyphen or contain two consecutive hyphens. For
    /// example, my-user1. This username will allow you to access the InfluxDB UI to
    /// perform various administrative tasks and also use the InfluxDB CLI to create
    /// an operator token. These attributes will be stored in a Secret created in
    /// Amazon Secrets Manager in your account.
    username: ?[]const u8 = null,

    /// A list of VPC security group IDs to associate with the DB instance.
    vpc_security_group_ids: []const []const u8,

    /// A list of VPC subnet IDs to associate with the DB instance. Provide at least
    /// two VPC subnet IDs in different availability zones when deploying with a
    /// Multi-AZ standby.
    vpc_subnet_ids: []const []const u8,

    pub const json_field_names = .{
        .allocated_storage = "allocatedStorage",
        .bucket = "bucket",
        .db_instance_type = "dbInstanceType",
        .db_parameter_group_identifier = "dbParameterGroupIdentifier",
        .db_storage_type = "dbStorageType",
        .deployment_type = "deploymentType",
        .log_delivery_configuration = "logDeliveryConfiguration",
        .name = "name",
        .network_type = "networkType",
        .organization = "organization",
        .password = "password",
        .port = "port",
        .publicly_accessible = "publiclyAccessible",
        .tags = "tags",
        .username = "username",
        .vpc_security_group_ids = "vpcSecurityGroupIds",
        .vpc_subnet_ids = "vpcSubnetIds",
    };
};

pub const CreateDbInstanceOutput = struct {
    /// The amount of storage allocated for your DB storage type (in gibibytes).
    allocated_storage: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the DB instance.
    arn: []const u8,

    /// The Availability Zone in which the DB instance resides.
    availability_zone: ?[]const u8 = null,

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

    /// Configuration for sending InfluxDB engine logs to send to specified S3
    /// bucket.
    log_delivery_configuration: ?LogDeliveryConfiguration = null,

    /// The customer-supplied name that uniquely identifies the DB instance when
    /// interacting with the Amazon Timestream for InfluxDB API and CLI commands.
    name: []const u8,

    /// Specifies whether the networkType of the Timestream for InfluxDB instance is
    /// IPV4, which can communicate over IPv4 protocol only, or DUAL, which can
    /// communicate over both IPv4 and IPv6 protocols.
    network_type: ?NetworkType = null,

    /// The port number on which InfluxDB accepts connections. The default value is
    /// 8086.
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
        .log_delivery_configuration = "logDeliveryConfiguration",
        .name = "name",
        .network_type = "networkType",
        .port = "port",
        .publicly_accessible = "publiclyAccessible",
        .secondary_availability_zone = "secondaryAvailabilityZone",
        .status = "status",
        .vpc_security_group_ids = "vpcSecurityGroupIds",
        .vpc_subnet_ids = "vpcSubnetIds",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDbInstanceInput, options: Options) !CreateDbInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "timestreaminfluxdb");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateDbInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("timestreaminfluxdb", "Timestream InfluxDB", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "AmazonTimestreamInfluxDB.CreateDbInstance");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateDbInstanceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDbInstanceOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
