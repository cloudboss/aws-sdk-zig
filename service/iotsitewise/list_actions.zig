const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResolveToResourceType = @import("resolve_to_resource_type.zig").ResolveToResourceType;
const TargetResourceType = @import("target_resource_type.zig").TargetResourceType;
const ActionSummary = @import("action_summary.zig").ActionSummary;

pub const ListActionsInput = struct {
    /// The maximum number of results to return for each paginated request.
    max_results: ?i32 = null,

    /// The token to be used for the next set of paginated results.
    next_token: ?[]const u8 = null,

    /// The ID of the resolved resource.
    resolve_to_resource_id: ?[]const u8 = null,

    /// The type of the resolved resource.
    resolve_to_resource_type: ?ResolveToResourceType = null,

    /// The ID of the target resource.
    target_resource_id: []const u8,

    /// The type of resource.
    target_resource_type: TargetResourceType,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .resolve_to_resource_id = "resolveToResourceId",
        .resolve_to_resource_type = "resolveToResourceType",
        .target_resource_id = "targetResourceId",
        .target_resource_type = "targetResourceType",
    };
};

pub const ListActionsOutput = struct {
    /// A list that summarizes the actions associated with the specified asset.
    action_summaries: ?[]const ActionSummary = null,

    /// The token for the next set of results, or null if there are no additional
    /// results.
    next_token: []const u8,

    pub const json_field_names = .{
        .action_summaries = "actionSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListActionsInput, options: CallOptions) !ListActionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListActionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/actions";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.resolve_to_resource_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "resolveToResourceId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.resolve_to_resource_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "resolveToResourceType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "targetResourceId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.target_resource_id);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "targetResourceType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.target_resource_type.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListActionsOutput {
    var result: ListActionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListActionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
