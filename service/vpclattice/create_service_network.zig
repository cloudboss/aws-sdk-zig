const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthType = @import("auth_type.zig").AuthType;
const SharingConfig = @import("sharing_config.zig").SharingConfig;

pub const CreateServiceNetworkInput = struct {
    /// The type of IAM policy.
    ///
    /// * `NONE`: The resource does not use an IAM policy. This is the default.
    /// * `AWS_IAM`: The resource uses an IAM policy. When this type is used, auth
    ///   is enabled and an auth policy is required.
    auth_type: ?AuthType = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you retry a request that completed
    /// successfully using the same client token and parameters, the retry succeeds
    /// without performing any actions. If the parameters aren't identical, the
    /// retry fails.
    client_token: ?[]const u8 = null,

    /// The name of the service network. The name must be unique to the account. The
    /// valid characters are a-z, 0-9, and hyphens (-). You can't use a hyphen as
    /// the first or last character, or immediately after another hyphen.
    name: []const u8,

    /// Specify if the service network should be enabled for sharing.
    sharing_config: ?SharingConfig = null,

    /// The tags for the service network.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .auth_type = "authType",
        .client_token = "clientToken",
        .name = "name",
        .sharing_config = "sharingConfig",
        .tags = "tags",
    };
};

pub const CreateServiceNetworkOutput = struct {
    /// The Amazon Resource Name (ARN) of the service network.
    arn: ?[]const u8 = null,

    /// The type of IAM policy.
    auth_type: ?AuthType = null,

    /// The ID of the service network.
    id: ?[]const u8 = null,

    /// The name of the service network.
    name: ?[]const u8 = null,

    /// Specifies if the service network is enabled for sharing.
    sharing_config: ?SharingConfig = null,

    pub const json_field_names = .{
        .arn = "arn",
        .auth_type = "authType",
        .id = "id",
        .name = "name",
        .sharing_config = "sharingConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServiceNetworkInput, options: CallOptions) !CreateServiceNetworkOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateServiceNetworkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/servicenetworks";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.auth_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.sharing_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sharingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateServiceNetworkOutput {
    var result: CreateServiceNetworkOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateServiceNetworkOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
