const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentStatus = @import("environment_status.zig").EnvironmentStatus;

pub const CreateKxEnvironmentInput = struct {
    /// A token that ensures idempotency. This token expires in 10 minutes.
    client_token: ?[]const u8 = null,

    /// A description for the kdb environment.
    description: ?[]const u8 = null,

    /// The KMS key ID to encrypt your data in the FinSpace environment.
    kms_key_id: []const u8,

    /// The name of the kdb environment that you want to create.
    name: []const u8,

    /// A list of key-value pairs to label the kdb environment. You can add up to 50
    /// tags to your kdb environment.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateKxEnvironmentOutput = struct {
    /// The timestamp at which the kdb environment was created in FinSpace.
    creation_timestamp: ?i64 = null,

    /// A description for the kdb environment.
    description: ?[]const u8 = null,

    /// The ARN identifier of the environment.
    environment_arn: ?[]const u8 = null,

    /// A unique identifier for the kdb environment.
    environment_id: ?[]const u8 = null,

    /// The KMS key ID to encrypt your data in the FinSpace environment.
    kms_key_id: ?[]const u8 = null,

    /// The name of the kdb environment.
    name: ?[]const u8 = null,

    /// The status of the kdb environment.
    status: ?EnvironmentStatus = null,

    pub const json_field_names = .{
        .creation_timestamp = "creationTimestamp",
        .description = "description",
        .environment_arn = "environmentArn",
        .environment_id = "environmentId",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateKxEnvironmentInput, options: CallOptions) !CreateKxEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "finspace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateKxEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/kx/environments";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"kmsKeyId\":");
    try aws.json.writeValue(@TypeOf(input.kms_key_id), input.kms_key_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateKxEnvironmentOutput {
    const result: CreateKxEnvironmentOutput = try aws.json.parseJsonObject(
        CreateKxEnvironmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
