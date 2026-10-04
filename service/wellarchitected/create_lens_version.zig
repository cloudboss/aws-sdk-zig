const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateLensVersionInput = struct {
    client_request_token: []const u8,

    /// Set to true if this new major lens version.
    is_major_version: ?bool = null,

    lens_alias: []const u8,

    /// The version of the lens being created.
    lens_version: []const u8,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .is_major_version = "IsMajorVersion",
        .lens_alias = "LensAlias",
        .lens_version = "LensVersion",
    };
};

pub const CreateLensVersionOutput = struct {
    /// The ARN for the lens.
    lens_arn: ?[]const u8 = null,

    /// The version of the lens.
    lens_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .lens_arn = "LensArn",
        .lens_version = "LensVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLensVersionInput, options: CallOptions) !CreateLensVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wellarchitected", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLensVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/lenses/");
    try path_buf.appendSlice(allocator, input.lens_alias);
    try path_buf.appendSlice(allocator, "/versions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
    try aws.json.writeValue(@TypeOf(input.client_request_token), input.client_request_token, allocator, &body_buf);
    has_prev = true;
    if (input.is_major_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IsMajorVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"LensVersion\":");
    try aws.json.writeValue(@TypeOf(input.lens_version), input.lens_version, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLensVersionOutput {
    var result: CreateLensVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateLensVersionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
