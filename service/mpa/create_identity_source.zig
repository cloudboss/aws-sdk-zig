const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentitySourceParameters = @import("identity_source_parameters.zig").IdentitySourceParameters;
const IdentitySourceType = @import("identity_source_type.zig").IdentitySourceType;

pub const CreateIdentitySourceInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. If not provided, the Amazon Web Services populates this
    /// field.
    ///
    /// **What is idempotency?**
    ///
    /// When you make a mutating API request, the request typically returns a result
    /// before the operation's asynchronous workflows have completed. Operations
    /// might also time out or encounter other server issues before they complete,
    /// even though the request has already returned a result. This could make it
    /// difficult to determine whether the request succeeded or not, and could lead
    /// to multiple retries to ensure that the operation completes successfully.
    /// However, if the original request and the subsequent retries are successful,
    /// the operation is completed multiple times. This means that you might create
    /// more resources than you intended.
    ///
    /// *Idempotency* ensures that an API request completes no more than one time.
    /// With an idempotent request, if the original request completes successfully,
    /// any subsequent retries complete successfully without performing any further
    /// actions.
    client_token: ?[]const u8 = null,

    /// A ` IdentitySourceParameters` object. Contains details for the resource that
    /// provides identities to the identity source. For example, an IAM Identity
    /// Center instance.
    identity_source_parameters: IdentitySourceParameters,

    /// Tag you want to attach to the identity source.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .identity_source_parameters = "IdentitySourceParameters",
        .tags = "Tags",
    };
};

pub const CreateIdentitySourceOutput = struct {
    /// Timestamp when the identity source was created.
    creation_time: ?i64 = null,

    /// Amazon Resource Name (ARN) for the identity source that was created.
    identity_source_arn: ?[]const u8 = null,

    /// The type of resource that provided identities to the identity source. For
    /// example, an IAM Identity Center instance.
    identity_source_type: ?IdentitySourceType = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .identity_source_arn = "IdentitySourceArn",
        .identity_source_type = "IdentitySourceType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIdentitySourceInput, options: CallOptions) !CreateIdentitySourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mpa", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIdentitySourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mpa", "MPA", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/identity-sources";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IdentitySourceParameters\":");
    try aws.json.writeValue(@TypeOf(input.identity_source_parameters), input.identity_source_parameters, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIdentitySourceOutput {
    const result: CreateIdentitySourceOutput = try aws.json.parseJsonObject(
        CreateIdentitySourceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
