const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListInvestigationGroupsModel = @import("list_investigation_groups_model.zig").ListInvestigationGroupsModel;

pub const ListInvestigationGroupsInput = struct {
    /// The maximum number of results to return in one operation. If you omit this
    /// parameter, the default of 50 is used.
    max_results: ?i32 = null,

    /// Include this value, if it was returned by the previous operation, to get the
    /// next set of service operations.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListInvestigationGroupsOutput = struct {
    /// An array of structures, where each structure contains the information about
    /// one investigation group in the account.
    investigation_groups: ?[]const ListInvestigationGroupsModel = null,

    /// Include this value in your next use of this operation to get the next set of
    /// service operations.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .investigation_groups = "investigationGroups",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInvestigationGroupsInput, options: CallOptions) !ListInvestigationGroupsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aiops", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInvestigationGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aiops", "AIOps", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/investigationGroups";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInvestigationGroupsOutput {
    const result: ListInvestigationGroupsOutput = try aws.json.parseJsonObject(
        ListInvestigationGroupsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
