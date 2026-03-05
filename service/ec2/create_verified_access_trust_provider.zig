const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CreateVerifiedAccessTrustProviderDeviceOptions = @import("create_verified_access_trust_provider_device_options.zig").CreateVerifiedAccessTrustProviderDeviceOptions;
const DeviceTrustProviderType = @import("device_trust_provider_type.zig").DeviceTrustProviderType;
const CreateVerifiedAccessNativeApplicationOidcOptions = @import("create_verified_access_native_application_oidc_options.zig").CreateVerifiedAccessNativeApplicationOidcOptions;
const CreateVerifiedAccessTrustProviderOidcOptions = @import("create_verified_access_trust_provider_oidc_options.zig").CreateVerifiedAccessTrustProviderOidcOptions;
const VerifiedAccessSseSpecificationRequest = @import("verified_access_sse_specification_request.zig").VerifiedAccessSseSpecificationRequest;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const TrustProviderType = @import("trust_provider_type.zig").TrustProviderType;
const UserTrustProviderType = @import("user_trust_provider_type.zig").UserTrustProviderType;
const VerifiedAccessTrustProvider = @import("verified_access_trust_provider.zig").VerifiedAccessTrustProvider;
const serde = @import("serde.zig");

pub const CreateVerifiedAccessTrustProviderInput = struct {
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
    device_options: ?CreateVerifiedAccessTrustProviderDeviceOptions = null,

    /// The type of device-based trust provider. This parameter is required when the
    /// provider
    /// type is `device`.
    device_trust_provider_type: ?DeviceTrustProviderType = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The OpenID Connect (OIDC) options.
    native_application_oidc_options: ?CreateVerifiedAccessNativeApplicationOidcOptions = null,

    /// The options for a OpenID Connect-compatible user-identity trust provider.
    /// This parameter
    /// is required when the provider type is `user`.
    oidc_options: ?CreateVerifiedAccessTrustProviderOidcOptions = null,

    /// The identifier to be used when working with policy rules.
    policy_reference_name: []const u8,

    /// The options for server side encryption.
    sse_specification: ?VerifiedAccessSseSpecificationRequest = null,

    /// The tags to assign to the Verified Access trust provider.
    tag_specifications: ?[]const TagSpecification = null,

    /// The type of trust provider.
    trust_provider_type: TrustProviderType,

    /// The type of user-based trust provider. This parameter is required when the
    /// provider type
    /// is `user`.
    user_trust_provider_type: ?UserTrustProviderType = null,
};

pub const CreateVerifiedAccessTrustProviderOutput = struct {
    /// Details about the Verified Access trust provider.
    verified_access_trust_provider: ?VerifiedAccessTrustProvider = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVerifiedAccessTrustProviderInput, options: CallOptions) !CreateVerifiedAccessTrustProviderOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVerifiedAccessTrustProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateVerifiedAccessTrustProvider&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.device_options) |v| {
        if (v.public_signing_key_url) |sv| {
            try body_buf.appendSlice(allocator, "&DeviceOptions.PublicSigningKeyUrl=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.tenant_id) |sv| {
            try body_buf.appendSlice(allocator, "&DeviceOptions.TenantId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    if (input.device_trust_provider_type) |v| {
        try body_buf.appendSlice(allocator, "&DeviceTrustProviderType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.native_application_oidc_options) |v| {
        if (v.authorization_endpoint) |sv| {
            try body_buf.appendSlice(allocator, "&NativeApplicationOidcOptions.AuthorizationEndpoint=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.client_id) |sv| {
            try body_buf.appendSlice(allocator, "&NativeApplicationOidcOptions.ClientId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.client_secret) |sv| {
            try body_buf.appendSlice(allocator, "&NativeApplicationOidcOptions.ClientSecret=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.issuer) |sv| {
            try body_buf.appendSlice(allocator, "&NativeApplicationOidcOptions.Issuer=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.public_signing_key_endpoint) |sv| {
            try body_buf.appendSlice(allocator, "&NativeApplicationOidcOptions.PublicSigningKeyEndpoint=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.scope) |sv| {
            try body_buf.appendSlice(allocator, "&NativeApplicationOidcOptions.Scope=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.token_endpoint) |sv| {
            try body_buf.appendSlice(allocator, "&NativeApplicationOidcOptions.TokenEndpoint=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.user_info_endpoint) |sv| {
            try body_buf.appendSlice(allocator, "&NativeApplicationOidcOptions.UserInfoEndpoint=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    if (input.oidc_options) |v| {
        if (v.authorization_endpoint) |sv| {
            try body_buf.appendSlice(allocator, "&OidcOptions.AuthorizationEndpoint=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.client_id) |sv| {
            try body_buf.appendSlice(allocator, "&OidcOptions.ClientId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.client_secret) |sv| {
            try body_buf.appendSlice(allocator, "&OidcOptions.ClientSecret=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.issuer) |sv| {
            try body_buf.appendSlice(allocator, "&OidcOptions.Issuer=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.scope) |sv| {
            try body_buf.appendSlice(allocator, "&OidcOptions.Scope=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.token_endpoint) |sv| {
            try body_buf.appendSlice(allocator, "&OidcOptions.TokenEndpoint=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.user_info_endpoint) |sv| {
            try body_buf.appendSlice(allocator, "&OidcOptions.UserInfoEndpoint=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    try body_buf.appendSlice(allocator, "&PolicyReferenceName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.policy_reference_name);
    if (input.sse_specification) |v| {
        if (v.customer_managed_key_enabled) |sv| {
            try body_buf.appendSlice(allocator, "&SseSpecification.CustomerManagedKeyEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
        if (v.kms_key_arn) |sv| {
            try body_buf.appendSlice(allocator, "&SseSpecification.KmsKeyArn=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    try body_buf.appendSlice(allocator, "&TrustProviderType=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.trust_provider_type.wireName());
    if (input.user_trust_provider_type) |v| {
        try body_buf.appendSlice(allocator, "&UserTrustProviderType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVerifiedAccessTrustProviderOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateVerifiedAccessTrustProviderOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "verifiedAccessTrustProvider")) {
                    result.verified_access_trust_provider = try serde.deserializeVerifiedAccessTrustProvider(allocator, &reader);
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
