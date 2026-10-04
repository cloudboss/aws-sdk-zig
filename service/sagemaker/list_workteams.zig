const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListWorkteamsSortByOptions = @import("list_workteams_sort_by_options.zig").ListWorkteamsSortByOptions;
const SortOrder = @import("sort_order.zig").SortOrder;
const Workteam = @import("workteam.zig").Workteam;

pub const ListWorkteamsInput = struct {
    /// The maximum number of work teams to return in each page of the response.
    max_results: ?i32 = null,

    /// A string in the work team's name. This filter returns only work teams whose
    /// name contains the specified string.
    name_contains: ?[]const u8 = null,

    /// If the result of the previous `ListWorkteams` request was truncated, the
    /// response includes a `NextToken`. To retrieve the next set of labeling jobs,
    /// use the token in the next request.
    next_token: ?[]const u8 = null,

    /// The field to sort results by. The default is `CreationTime`.
    sort_by: ?ListWorkteamsSortByOptions = null,

    /// The sort order for results. The default is `Ascending`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListWorkteamsOutput = struct {
    /// If the response is truncated, Amazon SageMaker returns this token. To
    /// retrieve the next set of work teams, use it in the subsequent request.
    next_token: ?[]const u8 = null,

    /// An array of `Workteam` objects, each describing a work team.
    workteams: ?[]const Workteam = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .workteams = "Workteams",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWorkteamsInput, options: CallOptions) !ListWorkteamsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWorkteamsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListWorkteams");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWorkteamsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListWorkteamsOutput, body, allocator);
}
