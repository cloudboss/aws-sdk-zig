const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NetworkFabricType = @import("network_fabric_type.zig").NetworkFabricType;
const EnvironmentState = @import("environment_state.zig").EnvironmentState;

pub const CreateEnvironmentInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request.
    client_token: ?[]const u8 = null,

    /// The description of the environment.
    description: ?[]const u8 = null,

    /// The name of the environment.
    name: []const u8,

    /// The network fabric type of the environment.
    network_fabric_type: NetworkFabricType,

    /// The tags to assign to the environment. A tag is a label that you assign to
    /// an Amazon Web Services resource. Each tag consists of a key-value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .name = "Name",
        .network_fabric_type = "NetworkFabricType",
        .tags = "Tags",
    };
};

pub const CreateEnvironmentOutput = struct {
    /// The Amazon Resource Name (ARN) of the environment.
    arn: ?[]const u8 = null,

    /// A timestamp that indicates when the environment is created.
    created_time: ?i64 = null,

    /// A description of the environment.
    description: ?[]const u8 = null,

    /// The unique identifier of the environment.
    environment_id: ?[]const u8 = null,

    /// A timestamp that indicates when the environment was last updated.
    last_updated_time: ?i64 = null,

    /// The name of the environment.
    name: ?[]const u8 = null,

    /// The network fabric type of the environment.
    network_fabric_type: ?NetworkFabricType = null,

    /// The Amazon Web Services account ID of environment owner.
    owner_account_id: ?[]const u8 = null,

    /// The current state of the environment.
    state: ?EnvironmentState = null,

    /// The tags assigned to the created environment. A tag is a label that you
    /// assign to an Amazon Web Services resource. Each tag consists of a key-value
    /// pair..
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .description = "Description",
        .environment_id = "EnvironmentId",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .network_fabric_type = "NetworkFabricType",
        .owner_account_id = "OwnerAccountId",
        .state = "State",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEnvironmentInput, options: CallOptions) !CreateEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "refactor-spaces", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("refactor-spaces", "Migration Hub Refactor Spaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/environments";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"NetworkFabricType\":");
    try aws.json.writeValue(@TypeOf(input.network_fabric_type), input.network_fabric_type, allocator, &body_buf);
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
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEnvironmentOutput {
    const result: CreateEnvironmentOutput = try aws.json.parseJsonObject(
        CreateEnvironmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
