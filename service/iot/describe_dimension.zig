const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DimensionType = @import("dimension_type.zig").DimensionType;

pub const DescribeDimensionInput = struct {
    /// The unique identifier for the dimension.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};

pub const DescribeDimensionOutput = struct {
    /// The Amazon Resource Name
    /// (ARN)
    /// for
    /// the dimension.
    arn: ?[]const u8 = null,

    /// The date the dimension was created.
    creation_date: ?i64 = null,

    /// The date the dimension was last modified.
    last_modified_date: ?i64 = null,

    /// The unique identifier for the dimension.
    name: ?[]const u8 = null,

    /// The value or list of values used to scope the dimension. For example, for
    /// topic filters, this is the pattern used to match the MQTT topic name.
    string_values: ?[]const []const u8 = null,

    /// The type of the dimension.
    type: ?DimensionType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date = "creationDate",
        .last_modified_date = "lastModifiedDate",
        .name = "name",
        .string_values = "stringValues",
        .type = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDimensionInput, options: CallOptions) !DescribeDimensionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDimensionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/dimensions/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDimensionOutput {
    const result: DescribeDimensionOutput = try aws.json.parseJsonObject(
        DescribeDimensionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
