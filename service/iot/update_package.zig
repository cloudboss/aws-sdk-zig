const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdatePackageInput = struct {
    /// A unique case-sensitive identifier that you can provide to ensure the
    /// idempotency of the request.
    /// Don't reuse this client token if a new idempotent request is required.
    client_token: ?[]const u8 = null,

    /// The name of the default package version.
    ///
    /// **Note:** You cannot name a `defaultVersion`
    /// and set `unsetDefaultVersion` equal to `true` at the same time.
    default_version_name: ?[]const u8 = null,

    /// The package description.
    description: ?[]const u8 = null,

    /// The name of the target software package.
    package_name: []const u8,

    /// Indicates whether you want to remove the named default package version from
    /// the software package.
    /// Set as `true` to remove the default package version.
    ///
    /// **Note:** You cannot name a `defaultVersion`
    /// and set `unsetDefaultVersion` equal to `true` at the same time.
    unset_default_version: ?bool = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .default_version_name = "defaultVersionName",
        .description = "description",
        .package_name = "packageName",
        .unset_default_version = "unsetDefaultVersion",
    };
};

pub const UpdatePackageOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePackageInput, options: CallOptions) !UpdatePackageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePackageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/packages/");
    try path_buf.appendSlice(allocator, input.package_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.client_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clientToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.default_version_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"defaultVersionName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.unset_default_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"unsetDefaultVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePackageOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdatePackageOutput = .{};

    return result;
}
