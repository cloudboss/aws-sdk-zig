const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TargetGroupConfig = @import("target_group_config.zig").TargetGroupConfig;
const TargetGroupType = @import("target_group_type.zig").TargetGroupType;
const TargetGroupStatus = @import("target_group_status.zig").TargetGroupStatus;

pub const CreateTargetGroupInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you retry a request that completed
    /// successfully using the same client token and parameters, the retry succeeds
    /// without performing any actions. If the parameters aren't identical, the
    /// retry fails.
    client_token: ?[]const u8 = null,

    /// The target group configuration.
    config: ?TargetGroupConfig = null,

    /// The name of the target group. The name must be unique within the account.
    /// The valid characters are a-z, 0-9, and hyphens (-). You can't use a hyphen
    /// as the first or last character, or immediately after another hyphen.
    name: []const u8,

    /// The tags for the target group.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of target group.
    type: TargetGroupType,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .config = "config",
        .name = "name",
        .tags = "tags",
        .type = "type",
    };
};

pub const CreateTargetGroupOutput = struct {
    /// The Amazon Resource Name (ARN) of the target group.
    arn: ?[]const u8 = null,

    /// The target group configuration.
    config: ?TargetGroupConfig = null,

    /// The ID of the target group.
    id: ?[]const u8 = null,

    /// The name of the target group.
    name: ?[]const u8 = null,

    /// The status. You can retry the operation if the status is `CREATE_FAILED`.
    /// However, if you retry it while the status is `CREATE_IN_PROGRESS`, there is
    /// no change in the status.
    status: ?TargetGroupStatus = null,

    /// The type of target group.
    type: ?TargetGroupType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .config = "config",
        .id = "id",
        .name = "name",
        .status = "status",
        .type = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTargetGroupInput, options: CallOptions) !CreateTargetGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "vpc-lattice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTargetGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/targetgroups";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"config\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.type), input.type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTargetGroupOutput {
    const result: CreateTargetGroupOutput = try aws.json.parseJsonObject(
        CreateTargetGroupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
