const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ModifyVerifiedAccessTrustProviderDeviceOptions = @import("modify_verified_access_trust_provider_device_options.zig").ModifyVerifiedAccessTrustProviderDeviceOptions;
const ModifyVerifiedAccessNativeApplicationOidcOptions = @import("modify_verified_access_native_application_oidc_options.zig").ModifyVerifiedAccessNativeApplicationOidcOptions;
const ModifyVerifiedAccessTrustProviderOidcOptions = @import("modify_verified_access_trust_provider_oidc_options.zig").ModifyVerifiedAccessTrustProviderOidcOptions;
const VerifiedAccessSseSpecificationRequest = @import("verified_access_sse_specification_request.zig").VerifiedAccessSseSpecificationRequest;
const VerifiedAccessTrustProvider = @import("verified_access_trust_provider.zig").VerifiedAccessTrustProvider;
const serde = @import("serde.zig");

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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyVerifiedAccessTrustProviderOutput) void {
        self._arena.deinit();
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyVerifiedAccessTrustProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyVerifiedAccessTrustProvider&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.device_options) |v| {
        if (v.public_signing_key_url) |sv| {
            try body_buf.appendSlice(alloc, "&DeviceOptions.PublicSigningKeyUrl=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.native_application_oidc_options) |v| {
        if (v.authorization_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&NativeApplicationOidcOptions.AuthorizationEndpoint=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.client_id) |sv| {
            try body_buf.appendSlice(alloc, "&NativeApplicationOidcOptions.ClientId=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.client_secret) |sv| {
            try body_buf.appendSlice(alloc, "&NativeApplicationOidcOptions.ClientSecret=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.issuer) |sv| {
            try body_buf.appendSlice(alloc, "&NativeApplicationOidcOptions.Issuer=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.public_signing_key_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&NativeApplicationOidcOptions.PublicSigningKeyEndpoint=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.scope) |sv| {
            try body_buf.appendSlice(alloc, "&NativeApplicationOidcOptions.Scope=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.token_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&NativeApplicationOidcOptions.TokenEndpoint=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.user_info_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&NativeApplicationOidcOptions.UserInfoEndpoint=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.oidc_options) |v| {
        if (v.authorization_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&OidcOptions.AuthorizationEndpoint=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.client_id) |sv| {
            try body_buf.appendSlice(alloc, "&OidcOptions.ClientId=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.client_secret) |sv| {
            try body_buf.appendSlice(alloc, "&OidcOptions.ClientSecret=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.issuer) |sv| {
            try body_buf.appendSlice(alloc, "&OidcOptions.Issuer=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.scope) |sv| {
            try body_buf.appendSlice(alloc, "&OidcOptions.Scope=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.token_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&OidcOptions.TokenEndpoint=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.user_info_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&OidcOptions.UserInfoEndpoint=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.sse_specification) |v| {
        if (v.customer_managed_key_enabled) |sv| {
            try body_buf.appendSlice(alloc, "&SseSpecification.CustomerManagedKeyEnabled=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.kms_key_arn) |sv| {
            try body_buf.appendSlice(alloc, "&SseSpecification.KmsKeyArn=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    try body_buf.appendSlice(alloc, "&VerifiedAccessTrustProviderId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.verified_access_trust_provider_id);

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
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyVerifiedAccessTrustProviderOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "verifiedAccessTrustProvider")) {
                    result.verified_access_trust_provider = try serde.deserializeVerifiedAccessTrustProvider(&reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
