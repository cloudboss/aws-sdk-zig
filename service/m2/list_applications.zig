const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationSummary = @import("application_summary.zig").ApplicationSummary;

pub const ListApplicationsInput = struct {
    /// The unique identifier of the runtime environment where the applications are
    /// deployed.
    environment_id: ?[]const u8 = null,

    /// The maximum number of applications to return.
    max_results: ?i32 = null,

    /// The names of the applications.
    names: ?[]const []const u8 = null,

    /// A pagination token to control the number of applications displayed in the
    /// list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .environment_id = "environmentId",
        .max_results = "maxResults",
        .names = "names",
        .next_token = "nextToken",
    };
};

pub const ListApplicationsOutput = struct {
    /// Returns a list of summary details for all the applications in a runtime
    /// environment.
    applications: ?[]const ApplicationSummary = null,

    /// A pagination token that's returned when the response doesn't contain all
    /// applications.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .applications = "applications",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListApplicationsInput, options: CallOptions) !ListApplicationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "m2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListApplicationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("m2", "m2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/applications";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.environment_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "environmentId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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
    if (input.names) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "names=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListApplicationsOutput {
    var result: ListApplicationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListApplicationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
