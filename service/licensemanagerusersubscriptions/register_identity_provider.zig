const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentityProvider = @import("identity_provider.zig").IdentityProvider;
const Settings = @import("settings.zig").Settings;
const IdentityProviderSummary = @import("identity_provider_summary.zig").IdentityProviderSummary;

pub const RegisterIdentityProviderInput = struct {
    /// An object that specifies details for the identity provider to register.
    identity_provider: IdentityProvider,

    /// The name of the user-based subscription product.
    ///
    /// Valid values: `VISUAL_STUDIO_ENTERPRISE` | `VISUAL_STUDIO_PROFESSIONAL` |
    /// `OFFICE_PROFESSIONAL_PLUS` | `REMOTE_DESKTOP_SERVICES`
    product: []const u8,

    /// The registered identity provider’s product related configuration settings
    /// such as the subnets to provision VPC endpoints.
    settings: ?Settings = null,

    /// The tags that apply to the identity provider's registration.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .identity_provider = "IdentityProvider",
        .product = "Product",
        .settings = "Settings",
        .tags = "Tags",
    };
};

pub const RegisterIdentityProviderOutput = struct {
    /// Metadata that describes the results of an identity provider operation.
    identity_provider_summary: ?IdentityProviderSummary = null,

    pub const json_field_names = .{
        .identity_provider_summary = "IdentityProviderSummary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterIdentityProviderInput, options: CallOptions) !RegisterIdentityProviderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterIdentityProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("license-manager-user-subscriptions", "License Manager User Subscriptions", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/identity-provider/RegisterIdentityProvider";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IdentityProvider\":");
    try aws.json.writeValue(@TypeOf(input.identity_provider), input.identity_provider, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Product\":");
    try aws.json.writeValue(@TypeOf(input.product), input.product, allocator, &body_buf);
    has_prev = true;
    if (input.settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Settings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterIdentityProviderOutput {
    var result: RegisterIdentityProviderOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RegisterIdentityProviderOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
