const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetSinkInput = struct {
    /// The ARN of the sink to retrieve information for.
    identifier: []const u8,

    /// Specifies whether to include the tags associated with the sink in the
    /// response. When `IncludeTags` is set to `true` and the caller has the
    /// required permission, `oam:ListTagsForResource`, the API will return the tags
    /// for the specified resource. If the caller doesn't have the required
    /// permission, `oam:ListTagsForResource`, the API will raise an exception.
    ///
    /// The default value is `false`.
    include_tags: ?bool = null,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .include_tags = "IncludeTags",
    };
};

pub const GetSinkOutput = struct {
    /// The ARN of the sink.
    arn: ?[]const u8 = null,

    /// The random ID string that Amazon Web Services generated as part of the sink
    /// ARN.
    id: ?[]const u8 = null,

    /// The name of the sink.
    name: ?[]const u8 = null,

    /// The tags assigned to the sink.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .name = "Name",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSinkInput, options: CallOptions) !GetSinkOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "oam", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSinkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("oam", "OAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetSink";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Identifier\":");
    try aws.json.writeValue(@TypeOf(input.identifier), input.identifier, allocator, &body_buf);
    has_prev = true;
    if (input.include_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncludeTags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSinkOutput {
    var result: GetSinkOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSinkOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
