const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Cluster = @import("cluster.zig").Cluster;

pub const RestoreClusterFromSnapshotInput = struct {
    /// The name of the elastic cluster.
    cluster_name: []const u8,

    /// The KMS key identifier to use to encrypt the new Amazon DocumentDB elastic
    /// clusters cluster.
    ///
    /// The KMS key identifier is the Amazon Resource Name (ARN) for the KMS
    /// encryption key. If you are creating a cluster using the same Amazon account
    /// that owns this KMS encryption key, you can use the KMS key alias instead
    /// of the ARN as the KMS encryption key.
    ///
    /// If an encryption key is not specified here, Amazon DocumentDB uses the
    /// default encryption key that KMS creates for your account. Your account
    /// has a different default encryption key for each Amazon Region.
    kms_key_id: ?[]const u8 = null,

    /// The capacity of each shard in the new restored elastic cluster.
    shard_capacity: ?i32 = null,

    /// The number of replica instances applying to all shards in the elastic
    /// cluster.
    /// A `shardInstanceCount` value of 1 means there is one writer instance, and
    /// any additional instances are replicas that can be used for reads and to
    /// improve availability.
    shard_instance_count: ?i32 = null,

    /// The ARN identifier of the elastic cluster snapshot.
    snapshot_arn: []const u8,

    /// The Amazon EC2 subnet IDs for the elastic cluster.
    subnet_ids: ?[]const []const u8 = null,

    /// A list of the tag names to be assigned to the restored elastic cluster, in
    /// the form of an array of key-value pairs in which the key is the tag name and
    /// the value is the key value.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A list of EC2 VPC security groups to associate with the elastic cluster.
    vpc_security_group_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .cluster_name = "clusterName",
        .kms_key_id = "kmsKeyId",
        .shard_capacity = "shardCapacity",
        .shard_instance_count = "shardInstanceCount",
        .snapshot_arn = "snapshotArn",
        .subnet_ids = "subnetIds",
        .tags = "tags",
        .vpc_security_group_ids = "vpcSecurityGroupIds",
    };
};

pub const RestoreClusterFromSnapshotOutput = struct {
    /// Returns information about a the restored elastic cluster.
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "cluster",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreClusterFromSnapshotInput, options: Options) !RestoreClusterFromSnapshotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "docdbelastic");

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

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreClusterFromSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("docdbelastic", "DocDB Elastic", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/cluster-snapshot/");
    try path_buf.appendSlice(allocator, input.snapshot_arn);
    try path_buf.appendSlice(allocator, "/restore");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clusterName\":");
    try aws.json.writeValue(@TypeOf(input.cluster_name), input.cluster_name, allocator, &body_buf);
    has_prev = true;
    if (input.kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.shard_capacity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"shardCapacity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.shard_instance_count) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"shardInstanceCount\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.subnet_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"subnetIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_security_group_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"vpcSecurityGroupIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreClusterFromSnapshotOutput {
    var result: RestoreClusterFromSnapshotOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RestoreClusterFromSnapshotOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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
