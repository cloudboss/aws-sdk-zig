const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CollectionGroupCapacityLimits = @import("collection_group_capacity_limits.zig").CollectionGroupCapacityLimits;
const StandbyReplicas = @import("standby_replicas.zig").StandbyReplicas;
const Tag = @import("tag.zig").Tag;
const CreateCollectionGroupDetail = @import("create_collection_group_detail.zig").CreateCollectionGroupDetail;

pub const CreateCollectionGroupInput = struct {
    /// The capacity limits for the collection group, in OpenSearch Compute Units
    /// (OCUs). These limits control the maximum and minimum capacity for
    /// collections within the group.
    capacity_limits: ?CollectionGroupCapacityLimits = null,

    /// Unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// A description of the collection group.
    description: ?[]const u8 = null,

    /// The name of the collection group.
    name: []const u8,

    /// Indicates whether standby replicas should be used for a collection group.
    standby_replicas: StandbyReplicas,

    /// An arbitrary set of tags (key–value pairs) to associate with the OpenSearch
    /// Serverless collection group.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .capacity_limits = "capacityLimits",
        .client_token = "clientToken",
        .description = "description",
        .name = "name",
        .standby_replicas = "standbyReplicas",
        .tags = "tags",
    };
};

pub const CreateCollectionGroupOutput = struct {
    /// Details about the created collection group.
    create_collection_group_detail: ?CreateCollectionGroupDetail = null,

    pub const json_field_names = .{
        .create_collection_group_detail = "createCollectionGroupDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCollectionGroupInput, options: CallOptions) !CreateCollectionGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aoss", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCollectionGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aoss", "OpenSearchServerless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "OpenSearchServerless.CreateCollectionGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCollectionGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCollectionGroupOutput, body, allocator);
}
