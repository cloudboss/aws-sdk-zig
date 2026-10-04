const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentityProvider = @import("identity_provider.zig").IdentityProvider;
const IdentityProviderSummary = @import("identity_provider_summary.zig").IdentityProviderSummary;

pub const DeregisterIdentityProviderInput = struct {
    /// An object that specifies details for the Active Directory identity provider.
    identity_provider: ?IdentityProvider = null,

    /// The Amazon Resource Name (ARN) that identifies the identity provider to
    /// deregister.
    identity_provider_arn: ?[]const u8 = null,

    /// The name of the user-based subscription product.
    ///
    /// Valid values: `VISUAL_STUDIO_ENTERPRISE` | `VISUAL_STUDIO_PROFESSIONAL` |
    /// `OFFICE_PROFESSIONAL_PLUS` | `OFFICE_STANDARD` | `REMOTE_DESKTOP_SERVICES`
    product: ?[]const u8 = null,

    pub const json_field_names = .{
        .identity_provider = "IdentityProvider",
        .identity_provider_arn = "IdentityProviderArn",
        .product = "Product",
    };
};

pub const DeregisterIdentityProviderOutput = struct {
    /// Metadata that describes the results of an identity provider operation.
    identity_provider_summary: ?IdentityProviderSummary = null,

    pub const json_field_names = .{
        .identity_provider_summary = "IdentityProviderSummary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeregisterIdentityProviderInput, options: CallOptions) !DeregisterIdentityProviderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeregisterIdentityProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("license-manager-user-subscriptions", "License Manager User Subscriptions", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/identity-provider/DeregisterIdentityProvider";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.identity_provider) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IdentityProvider\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.identity_provider_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IdentityProviderArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.product) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Product\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeregisterIdentityProviderOutput {
    const result: DeregisterIdentityProviderOutput = try aws.json.parseJsonObject(
        DeregisterIdentityProviderOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
