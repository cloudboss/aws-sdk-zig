const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateRoleAliasInput = struct {
    /// How long (in seconds) the credentials will be valid. The default value is
    /// 3,600 seconds.
    ///
    /// This value must be less than or equal to the maximum session duration of the
    /// IAM role
    /// that the role alias references.
    credential_duration_seconds: ?i32 = null,

    /// The role alias that points to a role ARN. This allows you to change the role
    /// without
    /// having to update the device.
    role_alias: []const u8,

    /// The role ARN.
    role_arn: []const u8,

    /// Metadata which can be used to manage the role alias.
    ///
    /// For URI Request parameters use format: ...key1=value1&key2=value2...
    ///
    /// For the CLI command-line parameter use format: &&tags
    /// "key1=value1&key2=value2..."
    ///
    /// For the cli-input-json file use format: "tags":
    /// "key1=value1&key2=value2..."
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .credential_duration_seconds = "credentialDurationSeconds",
        .role_alias = "roleAlias",
        .role_arn = "roleArn",
        .tags = "tags",
    };
};

pub const CreateRoleAliasOutput = struct {
    /// The role alias.
    role_alias: ?[]const u8 = null,

    /// The role alias ARN.
    role_alias_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .role_alias = "roleAlias",
        .role_alias_arn = "roleAliasArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRoleAliasInput, options: CallOptions) !CreateRoleAliasOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRoleAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/role-aliases/");
    try path_buf.appendSlice(allocator, input.role_alias);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.credential_duration_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"credentialDurationSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRoleAliasOutput {
    var result: CreateRoleAliasOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateRoleAliasOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
