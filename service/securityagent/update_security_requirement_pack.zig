const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SecurityRequirementPackStatus = @import("security_requirement_pack_status.zig").SecurityRequirementPackStatus;

pub const UpdateSecurityRequirementPackInput = struct {
    /// The updated description of the security requirement pack.
    description: ?[]const u8 = null,

    /// The updated name of the security requirement pack.
    name: ?[]const u8 = null,

    /// The unique identifier of the security requirement pack to update.
    pack_id: []const u8,

    /// The updated status of the security requirement pack.
    status: ?SecurityRequirementPackStatus = null,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .pack_id = "packId",
        .status = "status",
    };
};

pub const UpdateSecurityRequirementPackOutput = struct {
    /// The description of the security requirement pack.
    description: ?[]const u8 = null,

    /// The name of the security requirement pack.
    name: ?[]const u8 = null,

    /// The unique identifier of the security requirement pack.
    pack_id: []const u8,

    /// The status of the security requirement pack.
    status: ?SecurityRequirementPackStatus = null,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .pack_id = "packId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSecurityRequirementPackInput, options: CallOptions) !UpdateSecurityRequirementPackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityagent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSecurityRequirementPackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateSecurityRequirementPack";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"packId\":");
    try aws.json.writeValue(@TypeOf(input.pack_id), input.pack_id, allocator, &body_buf);
    has_prev = true;
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSecurityRequirementPackOutput {
    const result: UpdateSecurityRequirementPackOutput = try aws.json.parseJsonObject(
        UpdateSecurityRequirementPackOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
