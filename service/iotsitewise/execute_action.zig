const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionPayload = @import("action_payload.zig").ActionPayload;
const ResolveTo = @import("resolve_to.zig").ResolveTo;
const TargetResource = @import("target_resource.zig").TargetResource;

pub const ExecuteActionInput = struct {
    /// The ID of the action definition.
    action_definition_id: []const u8,

    /// The JSON payload of the action.
    action_payload: ActionPayload,

    /// A unique case-sensitive identifier that you can provide to ensure the
    /// idempotency of the request. Don't reuse this client token if a new
    /// idempotent request is required.
    client_token: ?[]const u8 = null,

    /// The detailed resource this action resolves to.
    resolve_to: ?ResolveTo = null,

    /// The resource the action will be taken on.
    target_resource: TargetResource,

    pub const json_field_names = .{
        .action_definition_id = "actionDefinitionId",
        .action_payload = "actionPayload",
        .client_token = "clientToken",
        .resolve_to = "resolveTo",
        .target_resource = "targetResource",
    };
};

pub const ExecuteActionOutput = struct {
    /// The ID of the action.
    action_id: []const u8,

    pub const json_field_names = .{
        .action_id = "actionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExecuteActionInput, options: CallOptions) !ExecuteActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ExecuteActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/actions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"actionDefinitionId\":");
    try aws.json.writeValue(@TypeOf(input.action_definition_id), input.action_definition_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"actionPayload\":");
    try aws.json.writeValue(@TypeOf(input.action_payload), input.action_payload, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resolve_to) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resolveTo\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetResource\":");
    try aws.json.writeValue(@TypeOf(input.target_resource), input.target_resource, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExecuteActionOutput {
    const result: ExecuteActionOutput = try aws.json.parseJsonObject(
        ExecuteActionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
