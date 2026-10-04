const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetLoaderJobStatusInput = struct {
    /// Flag indicating whether or not to include details beyond the overall status
    /// (`TRUE` or `FALSE`; the default is `FALSE`).
    details: ?bool = null,

    /// Flag indicating whether or not to include a list of errors encountered
    /// (`TRUE` or `FALSE`; the default is `FALSE`).
    ///
    /// The list of errors is paged. The `page` and `errorsPerPage` parameters allow
    /// you to page through all the errors.
    errors: ?bool = null,

    /// The number of errors returned in each page (a positive integer; the default
    /// is `10`). Only valid when the `errors` parameter set to `TRUE`.
    errors_per_page: ?i32 = null,

    /// The load ID of the load job to get the status of.
    load_id: []const u8,

    /// The error page number (a positive integer; the default is `1`). Only valid
    /// when the `errors` parameter is set to `TRUE`.
    page: ?i32 = null,

    pub const json_field_names = .{
        .details = "details",
        .errors = "errors",
        .errors_per_page = "errorsPerPage",
        .load_id = "loadId",
        .page = "page",
    };
};

pub const GetLoaderJobStatusOutput = struct {
    /// Status information about the load job, in a layout that could look like
    /// this:
    payload: []const u8,

    /// The HTTP response code for the request.
    status: []const u8,

    pub const json_field_names = .{
        .payload = "payload",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLoaderJobStatusInput, options: CallOptions) !GetLoaderJobStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "neptune-db", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLoaderJobStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-db", "neptunedata", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/loader/");
    try path_buf.appendSlice(allocator, input.load_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.details) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "details=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.errors) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "errors=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.errors_per_page) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "errorsPerPage=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.page) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "page=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLoaderJobStatusOutput {
    const result: GetLoaderJobStatusOutput = try aws.json.parseJsonObject(
        GetLoaderJobStatusOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
