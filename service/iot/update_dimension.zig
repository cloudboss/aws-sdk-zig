const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DimensionType = @import("dimension_type.zig").DimensionType;

pub const UpdateDimensionInput = struct {
    /// A unique identifier for the dimension. Choose something that describes the
    /// type and value to make it easy to remember what it does.
    name: []const u8,

    /// Specifies the value or list of values for the dimension. For `TOPIC_FILTER`
    /// dimensions, this is a pattern used to match the MQTT topic (for example,
    /// "admin/#").
    string_values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .string_values = "stringValues",
    };
};

pub const UpdateDimensionOutput = struct {
    /// The Amazon Resource
    /// Name (ARN)of
    /// the created dimension.
    arn: ?[]const u8 = null,

    /// The date and time, in milliseconds since epoch, when the dimension was
    /// initially created.
    creation_date: ?i64 = null,

    /// The date and time, in milliseconds since epoch, when the dimension was most
    /// recently updated.
    last_modified_date: ?i64 = null,

    /// A unique identifier for the dimension.
    name: ?[]const u8 = null,

    /// The value or list of values used to scope the dimension. For example, for
    /// topic filters, this is the pattern used to match the MQTT topic name.
    string_values: ?[]const []const u8 = null,

    /// The type of the dimension.
    @"type": ?DimensionType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date = "creationDate",
        .last_modified_date = "lastModifiedDate",
        .name = "name",
        .string_values = "stringValues",
        .@"type" = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDimensionInput, options: CallOptions) !UpdateDimensionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDimensionInput, config: *aws.Config) !aws.http.Request {
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
    try body_buf.appendSlice(allocator, "\"stringValues\":");
    try aws.json.writeValue(@TypeOf(input.string_values), input.string_values, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDimensionOutput {
    const result: UpdateDimensionOutput = try aws.json.parseJsonObject(
        UpdateDimensionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
