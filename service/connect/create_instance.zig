const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DirectoryType = @import("directory_type.zig").DirectoryType;

pub const CreateInstanceInput = struct {
    /// The idempotency token.
    client_token: ?[]const u8 = null,

    /// The identifier for the directory.
    directory_id: ?[]const u8 = null,

    /// The type of identity management for your Amazon Connect users.
    identity_management_type: DirectoryType,

    /// Your contact center handles incoming contacts.
    inbound_calls_enabled: bool,

    /// The name for your instance.
    instance_alias: ?[]const u8 = null,

    /// Your contact center allows outbound calls.
    outbound_calls_enabled: bool,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, `{ "tags":
    /// {"key1":"value1", "key2":"value2"} }`.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .directory_id = "DirectoryId",
        .identity_management_type = "IdentityManagementType",
        .inbound_calls_enabled = "InboundCallsEnabled",
        .instance_alias = "InstanceAlias",
        .outbound_calls_enabled = "OutboundCallsEnabled",
        .tags = "Tags",
    };
};

pub const CreateInstanceOutput = struct {
    /// The Amazon Resource Name (ARN) of the instance.
    arn: ?[]const u8 = null,

    /// The identifier for the instance.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInstanceInput, options: CallOptions) !CreateInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/instance";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.directory_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DirectoryId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IdentityManagementType\":");
    try aws.json.writeValue(@TypeOf(input.identity_management_type), input.identity_management_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InboundCallsEnabled\":");
    try aws.json.writeValue(@TypeOf(input.inbound_calls_enabled), input.inbound_calls_enabled, allocator, &body_buf);
    has_prev = true;
    if (input.instance_alias) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InstanceAlias\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OutboundCallsEnabled\":");
    try aws.json.writeValue(@TypeOf(input.outbound_calls_enabled), input.outbound_calls_enabled, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateInstanceOutput {
    var result: CreateInstanceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateInstanceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
