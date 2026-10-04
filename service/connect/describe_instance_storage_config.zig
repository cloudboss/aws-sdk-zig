const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceStorageResourceType = @import("instance_storage_resource_type.zig").InstanceStorageResourceType;
const InstanceStorageConfig = @import("instance_storage_config.zig").InstanceStorageConfig;

pub const DescribeInstanceStorageConfigInput = struct {
    /// The existing association identifier that uniquely identifies the resource
    /// type and storage config for the given instance ID.
    association_id: []const u8,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// A valid resource type.
    resource_type: InstanceStorageResourceType,

    pub const json_field_names = .{
        .association_id = "AssociationId",
        .instance_id = "InstanceId",
        .resource_type = "ResourceType",
    };
};

pub const DescribeInstanceStorageConfigOutput = struct {
    /// A valid storage type.
    storage_config: ?InstanceStorageConfig = null,

    pub const json_field_names = .{
        .storage_config = "StorageConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInstanceStorageConfigInput, options: CallOptions) !DescribeInstanceStorageConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInstanceStorageConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/instance/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/storage-config/");
    try path_buf.appendSlice(allocator, input.association_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "resourceType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.resource_type.wireName());
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInstanceStorageConfigOutput {
    const result: DescribeInstanceStorageConfigOutput = try aws.json.parseJsonObject(
        DescribeInstanceStorageConfigOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
