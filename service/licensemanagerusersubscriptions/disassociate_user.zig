const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentityProvider = @import("identity_provider.zig").IdentityProvider;
const InstanceUserSummary = @import("instance_user_summary.zig").InstanceUserSummary;

pub const DisassociateUserInput = struct {
    /// The domain name of the Active Directory that contains information for the
    /// user to disassociate.
    domain: ?[]const u8 = null,

    /// An object that specifies details for the Active Directory identity provider.
    identity_provider: ?IdentityProvider = null,

    /// The ID of the EC2 instance which provides user-based subscriptions.
    instance_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the user to disassociate from the EC2
    /// instance.
    instance_user_arn: ?[]const u8 = null,

    /// The user name from the Active Directory identity provider for the user.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain = "Domain",
        .identity_provider = "IdentityProvider",
        .instance_id = "InstanceId",
        .instance_user_arn = "InstanceUserArn",
        .username = "Username",
    };
};

pub const DisassociateUserOutput = struct {
    /// Metadata that describes the associate user operation.
    instance_user_summary: ?InstanceUserSummary = null,

    pub const json_field_names = .{
        .instance_user_summary = "InstanceUserSummary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateUserInput, options: CallOptions) !DisassociateUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "license-manager-user-subscriptions", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("license-manager-user-subscriptions", "License Manager User Subscriptions", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/user/DisassociateUser";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.domain) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Domain\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.identity_provider) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IdentityProvider\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.instance_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InstanceId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.instance_user_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InstanceUserArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.username) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Username\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateUserOutput {
    const result: DisassociateUserOutput = try aws.json.parseJsonObject(
        DisassociateUserOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
