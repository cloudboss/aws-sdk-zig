const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChronologicalOrder = @import("chronological_order.zig").ChronologicalOrder;
const ResourceType = @import("resource_type.zig").ResourceType;
const ConfigurationItem = @import("configuration_item.zig").ConfigurationItem;

pub const GetResourceConfigHistoryInput = struct {
    /// The chronological order for configuration items listed. By
    /// default, the results are listed in reverse chronological
    /// order.
    chronological_order: ?ChronologicalOrder = null,

    /// The chronologically earliest time in the time range for which the history
    /// requested. If not
    /// specified, the action returns paginated results that contain
    /// configuration items that start when the first configuration item was
    /// recorded.
    earlier_time: ?i64 = null,

    /// The chronologically latest time in the time range for which the history
    /// requested. If not specified,
    /// current time is taken.
    later_time: ?i64 = null,

    /// The maximum number of configuration items returned on each
    /// page. The default is 10. You cannot specify a number greater than
    /// 100. If you specify 0, Config uses the default.
    limit: ?i32 = null,

    /// The `nextToken` string returned on a previous page
    /// that you use to get the next page of results in a paginated
    /// response.
    next_token: ?[]const u8 = null,

    /// The ID of the resource (for example.,
    /// `sg-xxxxxx`).
    resource_id: []const u8,

    /// The resource type.
    resource_type: ResourceType,

    pub const json_field_names = .{
        .chronological_order = "chronologicalOrder",
        .earlier_time = "earlierTime",
        .later_time = "laterTime",
        .limit = "limit",
        .next_token = "nextToken",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
    };
};

pub const GetResourceConfigHistoryOutput = struct {
    /// An array of `ConfigurationItems` Objects. Contatins the configuration
    /// history for one or more
    /// resources.
    configuration_items: ?[]const ConfigurationItem = null,

    /// The string that you use in a subsequent request to get the next
    /// page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_items = "configurationItems",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceConfigHistoryInput, options: CallOptions) !GetResourceConfigHistoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceConfigHistoryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.GetResourceConfigHistory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceConfigHistoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetResourceConfigHistoryOutput, body, allocator);
}
