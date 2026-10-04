const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RestoreTestingSelectionForList = @import("restore_testing_selection_for_list.zig").RestoreTestingSelectionForList;

pub const ListRestoreTestingSelectionsInput = struct {
    /// The maximum number of items to be returned.
    max_results: ?i32 = null,

    /// The next item following a partial list of returned items.
    /// For example, if a request is made to return `MaxResults`
    /// number of items, `NextToken` allows you to return more items
    /// in your list starting at the location pointed to by the nexttoken.
    next_token: ?[]const u8 = null,

    /// Returns restore testing selections by the specified restore testing
    /// plan name.
    restore_testing_plan_name: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .restore_testing_plan_name = "RestoreTestingPlanName",
    };
};

pub const ListRestoreTestingSelectionsOutput = struct {
    /// The next item following a partial list of returned items. For example,
    /// if a request is made to return `MaxResults` number of items,
    /// `NextToken` allows you to return more items in your list
    /// starting at the location pointed to by the nexttoken.
    next_token: ?[]const u8 = null,

    /// The returned restore testing selections associated with the
    /// restore testing plan.
    restore_testing_selections: ?[]const RestoreTestingSelectionForList = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .restore_testing_selections = "RestoreTestingSelections",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRestoreTestingSelectionsInput, options: CallOptions) !ListRestoreTestingSelectionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRestoreTestingSelectionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restore-testing/plans/");
    try path_buf.appendSlice(allocator, input.restore_testing_plan_name);
    try path_buf.appendSlice(allocator, "/selections");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRestoreTestingSelectionsOutput {
    var result: ListRestoreTestingSelectionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListRestoreTestingSelectionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
