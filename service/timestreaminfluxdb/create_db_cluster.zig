const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DbInstanceType = @import("db_instance_type.zig").DbInstanceType;
const DbStorageType = @import("db_storage_type.zig").DbStorageType;
const ClusterDeploymentType = @import("cluster_deployment_type.zig").ClusterDeploymentType;
const FailoverMode = @import("failover_mode.zig").FailoverMode;
const LogDeliveryConfiguration = @import("log_delivery_configuration.zig").LogDeliveryConfiguration;
const NetworkType = @import("network_type.zig").NetworkType;
const ClusterStatus = @import("cluster_status.zig").ClusterStatus;

pub const CreateDbClusterInput = struct {
    /// The amount of storage to allocate for your DB storage type in GiB
    /// (gibibytes).
    allocated_storage: ?i32 = null,

    /// The name of the initial InfluxDB bucket. All InfluxDB data is stored in a
    /// bucket. A bucket combines the concept of a database and a retention period
    /// (the duration of time that each data point persists). A bucket belongs to an
    /// organization.
    bucket: ?[]const u8 = null,

    /// The Timestream for InfluxDB DB instance type to run InfluxDB on.
    db_instance_type: DbInstanceType,

    /// The ID of the DB parameter group to assign to your DB cluster. DB parameter
    /// groups specify how the database is configured. For example, DB parameter
    /// groups can specify the limit for query concurrency.
    db_parameter_group_identifier: ?[]const u8 = null,

    /// The Timestream for InfluxDB DB storage type to read and write InfluxDB data.
    ///
    /// You can choose between three different types of provisioned Influx IOPS
    /// Included storage according to your workload requirements:
    ///
    /// * Influx I/O Included 3000 IOPS
    ///
    /// * Influx I/O Included 12000 IOPS
    ///
    /// * Influx I/O Included 16000 IOPS
    db_storage_type: ?DbStorageType = null,

    /// Specifies the type of cluster to create.
    deployment_type: ?ClusterDeploymentType = null,

    /// Specifies the behavior of failure recovery when the primary node of the
    /// cluster fails.
    failover_mode: ?FailoverMode = null,

    /// Configuration for sending InfluxDB engine logs to a specified S3 bucket.
    log_delivery_configuration: ?LogDeliveryConfiguration = null,

    /// The name that uniquely identifies the DB cluster when interacting with the
    /// Amazon Timestream for InfluxDB API and CLI commands. This name will also be
    /// a prefix included in the endpoint. DB cluster names must be unique per
    /// customer and per region.
    name: []const u8,

    /// Specifies whether the network type of the Timestream for InfluxDB cluster is
    /// IPv4, which can communicate over IPv4 protocol only, or DUAL, which can
    /// communicate over both IPv4 and IPv6 protocols.
    network_type: ?NetworkType = null,

    /// The name of the initial organization for the initial admin user in InfluxDB.
    /// An InfluxDB organization is a workspace for a group of users.
    organization: ?[]const u8 = null,

    /// The password of the initial admin user created in InfluxDB. This password
    /// will allow
    /// you to access the InfluxDB UI to perform various administrative tasks and
    /// also use the
    /// InfluxDB CLI to create an operator token. These attributes will be stored in
    /// a secret created in Secrets Manager in your account.
    password: ?[]const u8 = null,

    /// The port number on which InfluxDB accepts connections.
    ///
    /// Valid Values: 1024-65535
    ///
    /// Default: 8086 for InfluxDB v2, 8181 for InfluxDB v3
    ///
    /// Constraints: The value can't be 2375-2376, 7788-7799, 8090, or 51678-51680
    port: ?i32 = null,

    /// Configures the Timestream for InfluxDB cluster with a public IP to
    /// facilitate access from outside the VPC.
    publicly_accessible: ?bool = null,

    /// A list of key-value pairs to associate with the DB instance.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The username of the initial admin user created in InfluxDB. Must start with
    /// a letter and can't end with a hyphen or contain two consecutive hyphens. For
    /// example, my-user1. This username will allow you to access the InfluxDB UI to
    /// perform various administrative tasks and also use the InfluxDB CLI to create
    /// an operator token. These attributes will be stored in a secret created in
    /// Secrets Manager in your account.
    username: ?[]const u8 = null,

    /// A list of VPC security group IDs to associate with the Timestream for
    /// InfluxDB cluster.
    vpc_security_group_ids: []const []const u8,

    /// A list of VPC subnet IDs to associate with the DB cluster. Provide at least
    /// two VPC subnet IDs in different Availability Zones when deploying with a
    /// Multi-AZ standby.
    vpc_subnet_ids: []const []const u8,

    pub const json_field_names = .{
        .allocated_storage = "allocatedStorage",
        .bucket = "bucket",
        .db_instance_type = "dbInstanceType",
        .db_parameter_group_identifier = "dbParameterGroupIdentifier",
        .db_storage_type = "dbStorageType",
        .deployment_type = "deploymentType",
        .failover_mode = "failoverMode",
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

pub const CreateDbClusterOutput = struct {
    /// A service-generated unique identifier.
    db_cluster_id: ?[]const u8 = null,

    /// The status of the DB cluster.
    db_cluster_status: ?ClusterStatus = null,

    pub const json_field_names = .{
        .db_cluster_id = "dbClusterId",
        .db_cluster_status = "dbClusterStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDbClusterInput, options: CallOptions) !CreateDbClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "timestream-influxdb");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDbClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("timestream-influxdb", "Timestream InfluxDB", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonTimestreamInfluxDB.CreateDbCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDbClusterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDbClusterOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
