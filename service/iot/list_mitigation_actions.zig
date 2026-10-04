const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MitigationActionType = @import("mitigation_action_type.zig").MitigationActionType;
const MitigationActionIdentifier = @import("mitigation_action_identifier.zig").MitigationActionIdentifier;

pub const ListMitigationActionsInput = struct {
    /// Specify a value to limit the result to mitigation actions with a specific
    /// action type.
    action_type: ?MitigationActionType = null,

    /// The maximum number of results to return at one time. The default is 25.
    max_results: ?i32 = null,

    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_type = "actionType",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListMitigationActionsOutput = struct {
    /// A set of actions that matched the specified filter criteria.
    action_identifiers: ?[]const MitigationActionIdentifier = null,

    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_identifiers = "actionIdentifiers",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMitigationActionsInput, options: CallOptions) !ListMitigationActionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMitigationActionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/mitigationactions/actions";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.action_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "actionType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMitigationActionsOutput {
    const result: ListMitigationActionsOutput = try aws.json.parseJsonObject(
        ListMitigationActionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
