const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceType = @import("resource_type.zig").ResourceType;
const ResourceIdentifier = @import("resource_identifier.zig").ResourceIdentifier;

pub const ListDiscoveredResourcesInput = struct {
    /// Specifies whether Config includes deleted resources in the
    /// results. By default, deleted resources are not included.
    include_deleted_resources: ?bool = null,

    /// The maximum number of resource identifiers returned on each
    /// page. The default is 100. You cannot specify a number greater than
    /// 100. If you specify 0, Config uses the default.
    limit: ?i32 = null,

    /// The `nextToken` string returned on a previous page
    /// that you use to get the next page of results in a paginated
    /// response.
    next_token: ?[]const u8 = null,

    /// The IDs of only those resources that you want Config to
    /// list in the response. If you do not specify this parameter, Config lists all
    /// resources of the specified type that it has
    /// discovered. You can list a minimum of 1 resourceID and a maximum of 20
    /// resourceIds.
    resource_ids: ?[]const []const u8 = null,

    /// The custom name of only those resources that you want Config to list in the
    /// response. If you do not specify this
    /// parameter, Config lists all resources of the specified type that
    /// it has discovered.
    resource_name: ?[]const u8 = null,

    /// The type of resources that you want Config to list in the
    /// response.
    resource_type: ResourceType,

    pub const json_field_names = .{
        .include_deleted_resources = "includeDeletedResources",
        .limit = "limit",
        .next_token = "nextToken",
        .resource_ids = "resourceIds",
        .resource_name = "resourceName",
        .resource_type = "resourceType",
    };
};

pub const ListDiscoveredResourcesOutput = struct {
    /// The string that you use in a subsequent request to get the next
    /// page of results in a paginated response.
    next_token: ?[]const u8 = null,

    /// The details that identify a resource that is discovered by Config, including
    /// the resource type, ID, and (if available) the
    /// custom resource name.
    resource_identifiers: ?[]const ResourceIdentifier = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .resource_identifiers = "resourceIdentifiers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDiscoveredResourcesInput, options: CallOptions) !ListDiscoveredResourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDiscoveredResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.ListDiscoveredResources");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDiscoveredResourcesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDiscoveredResourcesOutput, body, allocator);
}
