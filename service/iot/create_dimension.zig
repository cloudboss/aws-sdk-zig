const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const DimensionType = @import("dimension_type.zig").DimensionType;

pub const CreateDimensionInput = struct {
    /// Each dimension must have a unique client request token. If you try to create
    /// a new dimension with the same token as a dimension that already exists, an
    /// exception occurs.
    /// If you omit this value, Amazon Web Services SDKs will automatically generate
    /// a unique client request.
    client_request_token: []const u8,

    /// A unique identifier for the dimension. Choose something that describes the
    /// type and value to make it easy to remember what it does.
    name: []const u8,

    /// Specifies the value or list of values for the dimension. For `TOPIC_FILTER`
    /// dimensions, this is a pattern used to match the MQTT topic (for example,
    /// "admin/#").
    string_values: []const []const u8,

    /// Metadata that can be used to manage the dimension.
    tags: ?[]const Tag = null,

    /// Specifies the type of dimension. Supported types: `TOPIC_FILTER.`
    @"type": DimensionType,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .name = "name",
        .string_values = "stringValues",
        .tags = "tags",
        .@"type" = "type",
    };
};

pub const CreateDimensionOutput = struct {
    /// The Amazon Resource Name
    /// (ARN)
    /// of
    /// the created dimension.
    arn: ?[]const u8 = null,

    /// A unique identifier for the dimension.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDimensionInput, options: CallOptions) !CreateDimensionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDimensionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/dimensions/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
    try aws.json.writeValue(@TypeOf(input.client_request_token), input.client_request_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"stringValues\":");
    try aws.json.writeValue(@TypeOf(input.string_values), input.string_values, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDimensionOutput {
    var result: CreateDimensionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDimensionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
