const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserIdentifier = @import("user_identifier.zig").UserIdentifier;

pub const GetIdentityContextInput = struct {
    /// The ID for the Amazon Web Services account that the user whose identity
    /// context you want to retrieve is in. Currently, you use the ID for the Amazon
    /// Web Services account that contains your Quick Sight account.
    aws_account_id: []const u8,

    /// The region in which the context is to be used. Use this parameter to obtain
    /// an identity context for cross-region use.
    ///
    /// The specified region must meet the following conditions:
    ///
    /// * The region must be in the same Amazon Web Services partition as the region
    ///   you are calling from. Cross-partition requests are not supported. For
    ///   example, you cannot specify a region in the `aws-cn` partition when
    ///   calling from a region in the `aws` partition.
    ///
    /// * It must be a valid Amazon QuickSight supported region.
    ///
    /// * The calling customer account must be enabled in the specified context
    ///   region.
    ///
    /// * This parameter is not supported when calling from an opt-in region.
    context_region: ?[]const u8 = null,

    /// The namespace of the user that you want to get identity context for. This
    /// parameter is required when the UserIdentifier is specified using Email or
    /// UserName.
    namespace: ?[]const u8 = null,

    /// The timestamp at which the session will expire.
    session_expires_at: ?i64 = null,

    /// The identifier for the user whose identity context you want to retrieve.
    user_identifier: UserIdentifier,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .context_region = "ContextRegion",
        .namespace = "Namespace",
        .session_expires_at = "SessionExpiresAt",
        .user_identifier = "UserIdentifier",
    };
};

pub const GetIdentityContextOutput = struct {
    /// The identity context information for the user. This is an identity token
    /// that should be used as the ContextAssertion parameter in the [STS AssumeRole
    /// API](https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRole.html) call to obtain identity enhanced Amazon Web Services credentials.
    context: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: []const u8,

    /// The HTTP status of the request.
    status: i32,

    pub const json_field_names = .{
        .context = "Context",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIdentityContextInput, options: CallOptions) !GetIdentityContextOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIdentityContextInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/identity-context");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.context_region) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ContextRegion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.namespace) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Namespace\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.session_expires_at) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SessionExpiresAt\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"UserIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.user_identifier), input.user_identifier, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIdentityContextOutput {
    var result: GetIdentityContextOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetIdentityContextOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}
