const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreClusterFromSnapshotInput, options: CallOptions) !RestoreClusterFromSnapshotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "docdb-elastic", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreClusterFromSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("docdb-elastic", "DocDB Elastic", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/cluster-snapshot/");
    try path_buf.appendSlice(allocator, input.snapshot_arn);
    try path_buf.appendSlice(allocator, "/restore");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreClusterFromSnapshotOutput {
    const result: RestoreClusterFromSnapshotOutput = try aws.json.parseJsonObject(
        RestoreClusterFromSnapshotOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
