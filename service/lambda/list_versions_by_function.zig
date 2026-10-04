const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FunctionConfiguration = @import("function_configuration.zig").FunctionConfiguration;

pub const ListVersionsByFunctionInput = struct {
    /// The name or ARN of the Lambda function. **Name formats**
    ///
    /// * **Function name** - `MyFunction`.
    /// * **Function ARN** -
    ///   `arn:aws:lambda:us-west-2:123456789012:function:MyFunction`.
    /// * **Partial ARN** - `123456789012:function:MyFunction`.
    ///
    /// The length constraint applies only to the full ARN. If you specify only the
    /// function name, it is limited to 64 characters in length.
    function_name: []const u8,

    /// Specify the pagination token that's returned by a previous request to
    /// retrieve the next page of results.
    marker: ?[]const u8 = null,

    /// The maximum number of versions to return. Note that `ListVersionsByFunction`
    /// returns a maximum of 50 items in each response, even if you set the number
    /// higher.
    max_items: ?i32 = null,

    pub const json_field_names = .{
        .function_name = "FunctionName",
        .marker = "Marker",
        .max_items = "MaxItems",
    };
};

pub const ListVersionsByFunctionOutput = struct {
    /// The pagination token that's included if more results are available.
    next_marker: ?[]const u8 = null,

    /// A list of Lambda function versions.
    versions: ?[]const FunctionConfiguration = null,

    pub const json_field_names = .{
        .next_marker = "NextMarker",
        .versions = "Versions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListVersionsByFunctionInput, options: CallOptions) !ListVersionsByFunctionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListVersionsByFunctionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-03-31/functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/versions");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxItems=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListVersionsByFunctionOutput {
    const result: ListVersionsByFunctionOutput = try aws.json.parseJsonObject(
        ListVersionsByFunctionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
