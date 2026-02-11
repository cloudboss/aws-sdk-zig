const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ModifyVerifiedAccessTrustProviderDeviceOptions = @import("modify_verified_access_trust_provider_device_options.zig").ModifyVerifiedAccessTrustProviderDeviceOptions;
const ModifyVerifiedAccessNativeApplicationOidcOptions = @import("modify_verified_access_native_application_oidc_options.zig").ModifyVerifiedAccessNativeApplicationOidcOptions;
const ModifyVerifiedAccessTrustProviderOidcOptions = @import("modify_verified_access_trust_provider_oidc_options.zig").ModifyVerifiedAccessTrustProviderOidcOptions;
const VerifiedAccessSseSpecificationRequest = @import("verified_access_sse_specification_request.zig").VerifiedAccessSseSpecificationRequest;
const VerifiedAccessTrustProvider = @import("verified_access_trust_provider.zig").VerifiedAccessTrustProvider;

/// Modifies the configuration of the specified Amazon Web Services Verified
/// Access trust provider.
pub const ModifyVerifiedAccessTrustProviderInput = struct {
    /// A unique, case-sensitive token that you provide to ensure idempotency of
    /// your
    /// modification request. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// A description for the Verified Access trust provider.
    description: ?[]const u8 = null,

    /// The options for a device-based trust provider. This parameter is required
    /// when the
    /// provider type is `device`.
    device_options: ?ModifyVerifiedAccessTrustProviderDeviceOptions = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The OpenID Connect (OIDC) options.
    native_application_oidc_options: ?ModifyVerifiedAccessNativeApplicationOidcOptions = null,

    /// The options for an OpenID Connect-compatible user-identity trust provider.
    oidc_options: ?ModifyVerifiedAccessTrustProviderOidcOptions = null,

    /// The options for server side encryption.
    sse_specification: ?VerifiedAccessSseSpecificationRequest = null,

    /// The ID of the Verified Access trust provider.
    verified_access_trust_provider_id: []const u8,
};

pub const ModifyVerifiedAccessTrustProviderOutput = struct {
    /// Details about the Verified Access trust provider.
    verified_access_trust_provider: ?VerifiedAccessTrustProvider = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const ModifyVerifiedAccessTrustProviderOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyVerifiedAccessTrustProviderInput, options: Options) !ModifyVerifiedAccessTrustProviderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    return try deserializeResponse(response.body, response.status, response.headers, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyVerifiedAccessTrustProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyVerifiedAccessTrustProvider&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.device_options) |v| {
        if (v.public_signing_key_url) |sv| {
            try body_buf.appendSlice(alloc, "&DeviceOptions.PublicSigningKeyUrl=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.native_application_oidc_options) |v| {
        if (v.authorization_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&NativeApplicationOidcOptions.AuthorizationEndpoint=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.client_id) |sv| {
            try body_buf.appendSlice(alloc, "&NativeApplicationOidcOptions.ClientId=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.client_secret) |sv| {
            try body_buf.appendSlice(alloc, "&NativeApplicationOidcOptions.ClientSecret=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.issuer) |sv| {
            try body_buf.appendSlice(alloc, "&NativeApplicationOidcOptions.Issuer=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.public_signing_key_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&NativeApplicationOidcOptions.PublicSigningKeyEndpoint=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.scope) |sv| {
            try body_buf.appendSlice(alloc, "&NativeApplicationOidcOptions.Scope=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.token_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&NativeApplicationOidcOptions.TokenEndpoint=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.user_info_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&NativeApplicationOidcOptions.UserInfoEndpoint=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.oidc_options) |v| {
        if (v.authorization_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&OidcOptions.AuthorizationEndpoint=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.client_id) |sv| {
            try body_buf.appendSlice(alloc, "&OidcOptions.ClientId=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.client_secret) |sv| {
            try body_buf.appendSlice(alloc, "&OidcOptions.ClientSecret=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.issuer) |sv| {
            try body_buf.appendSlice(alloc, "&OidcOptions.Issuer=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.scope) |sv| {
            try body_buf.appendSlice(alloc, "&OidcOptions.Scope=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.token_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&OidcOptions.TokenEndpoint=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.user_info_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&OidcOptions.UserInfoEndpoint=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.sse_specification) |v| {
        if (v.customer_managed_key_enabled) |sv| {
            try body_buf.appendSlice(alloc, "&SseSpecification.CustomerManagedKeyEnabled=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.kms_key_arn) |sv| {
            try body_buf.appendSlice(alloc, "&SseSpecification.KmsKeyArn=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    try body_buf.appendSlice(alloc, "&VerifiedAccessTrustProviderId=");
    try appendUrlEncoded(alloc, &body_buf, input.verified_access_trust_provider_id);

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyVerifiedAccessTrustProviderOutput {
    _ = status;
    _ = headers;
    _ = body;
    const result: ModifyVerifiedAccessTrustProviderOutput = .{ .allocator = alloc };

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
