const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubjectSummary = @import("subject_summary.zig").SubjectSummary;

pub const ListSubjectsInput = struct {
    /// A token that indicates where the output should continue from, if a previous
    /// request did not show all results. To get the next results, make the request
    /// again with this value.
    next_token: ?[]const u8 = null,

    /// The number of resources in the paginated list.
    page_size: ?i32 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .page_size = "pageSize",
    };
};

pub const ListSubjectsOutput = struct {
    /// A token that indicates where the output should continue from, if a previous
    /// request did not show all results. To get the next results, make the request
    /// again with this value.
    next_token: ?[]const u8 = null,

    /// A list of subjects.
    subjects: ?[]const SubjectSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .subjects = "subjects",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSubjectsInput, options: CallOptions) !ListSubjectsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rolesanywhere", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSubjectsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rolesanywhere", "RolesAnywhere", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/subjects";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.page_size) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "pageSize=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSubjectsOutput {
    const result: ListSubjectsOutput = try aws.json.parseJsonObject(
        ListSubjectsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
