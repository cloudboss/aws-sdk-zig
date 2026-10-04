const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImportLensStatus = @import("import_lens_status.zig").ImportLensStatus;

pub const ImportLensInput = struct {
    client_request_token: []const u8,

    /// The JSON representation of a lens.
    json_string: []const u8,

    lens_alias: ?[]const u8 = null,

    /// Tags to associate to a lens.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .json_string = "JSONString",
        .lens_alias = "LensAlias",
        .tags = "Tags",
    };
};

pub const ImportLensOutput = struct {
    /// The ARN for the lens that was created or updated.
    lens_arn: ?[]const u8 = null,

    /// The status of the imported lens.
    status: ?ImportLensStatus = null,

    pub const json_field_names = .{
        .lens_arn = "LensArn",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportLensInput, options: CallOptions) !ImportLensOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportLensInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/importLens";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
    try aws.json.writeValue(@TypeOf(input.client_request_token), input.client_request_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"JSONString\":");
    try aws.json.writeValue(@TypeOf(input.json_string), input.json_string, allocator, &body_buf);
    has_prev = true;
    if (input.lens_alias) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LensAlias\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportLensOutput {
    var result: ImportLensOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ImportLensOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
