const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceIdentifier = @import("resource_identifier.zig").ResourceIdentifier;

pub const UpdateAuditSuppressionInput = struct {
    check_name: []const u8,

    /// The description of the audit suppression.
    description: ?[]const u8 = null,

    /// The expiration date (epoch timestamp in seconds) that you want the
    /// suppression to adhere to.
    expiration_date: ?i64 = null,

    resource_identifier: ResourceIdentifier,

    /// Indicates whether a suppression should exist indefinitely or not.
    suppress_indefinitely: ?bool = null,

    pub const json_field_names = .{
        .check_name = "checkName",
        .description = "description",
        .expiration_date = "expirationDate",
        .resource_identifier = "resourceIdentifier",
        .suppress_indefinitely = "suppressIndefinitely",
    };
};

pub const UpdateAuditSuppressionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAuditSuppressionInput, options: CallOptions) !UpdateAuditSuppressionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAuditSuppressionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/audit/suppressions/update";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"checkName\":");
    try aws.json.writeValue(@TypeOf(input.check_name), input.check_name, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.expiration_date) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"expirationDate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.resource_identifier), input.resource_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.suppress_indefinitely) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"suppressIndefinitely\":");
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
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAuditSuppressionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateAuditSuppressionOutput = .{};

    return result;
}
