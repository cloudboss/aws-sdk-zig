const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const APIName = @import("api_name.zig").APIName;

pub const GetDataEndpointInput = struct {
    /// The name of the API action for which to get an endpoint.
    api_name: APIName,

    /// The Amazon Resource Name (ARN) of the stream that you want to get the
    /// endpoint for.
    /// You must specify either this parameter or a `StreamName` in the request.
    stream_arn: ?[]const u8 = null,

    /// The name of the stream that you want to get the endpoint for. You must
    /// specify
    /// either this parameter or a `StreamARN` in the request.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_name = "APIName",
        .stream_arn = "StreamARN",
        .stream_name = "StreamName",
    };
};

pub const GetDataEndpointOutput = struct {
    /// The endpoint value. To read data from the stream or to write data to it,
    /// specify
    /// this endpoint in your application.
    data_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_endpoint = "DataEndpoint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataEndpointInput, options: CallOptions) !GetDataEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesisvideo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideo", "Kinesis Video", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/getDataEndpoint";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"APIName\":");
    try aws.json.writeValue(@TypeOf(input.api_name), input.api_name, allocator, &body_buf);
    has_prev = true;
    if (input.stream_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StreamARN\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stream_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StreamName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataEndpointOutput {
    const result: GetDataEndpointOutput = try aws.json.parseJsonObject(
        GetDataEndpointOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
