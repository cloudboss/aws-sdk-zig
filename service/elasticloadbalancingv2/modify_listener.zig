const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Certificate = @import("certificate.zig").Certificate;
const Action = @import("action.zig").Action;
const MutualAuthenticationAttributes = @import("mutual_authentication_attributes.zig").MutualAuthenticationAttributes;
const ProtocolEnum = @import("protocol_enum.zig").ProtocolEnum;
const Listener = @import("listener.zig").Listener;
const serde = @import("serde.zig");

pub const ModifyListenerInput = struct {
    /// [TLS listeners] The name of the Application-Layer Protocol Negotiation
    /// (ALPN) policy. You
    /// can specify one policy name. The following are the possible values:
    ///
    /// * `HTTP1Only`
    ///
    /// * `HTTP2Only`
    ///
    /// * `HTTP2Optional`
    ///
    /// * `HTTP2Preferred`
    ///
    /// * `None`
    ///
    /// For more information, see [ALPN
    /// policies](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-listeners.html#alpn-policies) in the *Network Load Balancers Guide*.
    alpn_policy: ?[]const []const u8 = null,

    /// [HTTPS and TLS listeners] The default certificate for the listener. You must
    /// provide
    /// exactly one certificate. Set `CertificateArn` to the certificate ARN but do
    /// not set
    /// `IsDefault`.
    certificates: ?[]const Certificate = null,

    /// The actions for the default rule.
    default_actions: ?[]const Action = null,

    /// The Amazon Resource Name (ARN) of the listener.
    listener_arn: []const u8,

    /// [HTTPS listeners] The mutual authentication configuration information.
    mutual_authentication: ?MutualAuthenticationAttributes = null,

    /// The port for connections from clients to the load balancer. You can't
    /// specify a port for
    /// a Gateway Load Balancer.
    port: ?i32 = null,

    /// The protocol for connections from clients to the load balancer. Application
    /// Load Balancers
    /// support the HTTP and HTTPS protocols. Network Load Balancers support the
    /// TCP, TLS, UDP,
    /// TCP_UDP, QUIC, and TCP_QUIC protocols. You can’t change the protocol to UDP,
    /// TCP_UDP, QUIC, or TCP_QUIC if dual-stack mode is
    /// enabled. You can't specify a protocol for a Gateway Load Balancer.
    protocol: ?ProtocolEnum = null,

    /// [HTTPS and TLS listeners] The security policy that defines which protocols
    /// and ciphers are
    /// supported.
    ///
    /// For more information, see [Security
    /// policies](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/describe-ssl-policies.html) in the *Application Load Balancers Guide* or
    /// [Security
    /// policies](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/describe-ssl-policies.html) in the *Network Load Balancers Guide*.
    ssl_policy: ?[]const u8 = null,
};

pub const ModifyListenerOutput = struct {
    /// Information about the modified listener.
    listeners: ?[]const Listener = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyListenerInput, options: CallOptions) !ModifyListenerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "elasticloadbalancingv2");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyListenerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancingv2", "Elastic Load Balancing v2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyListener&Version=2015-12-01");
    if (input.alpn_policy) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AlpnPolicy.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.certificates) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Certificates.member.{d}.CertificateArn=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.certificate_arn) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Certificates.member.{d}.IsDefault=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.is_default) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                }
            }
        }
    }
    if (input.default_actions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.authenticate_cognito_config) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateCognitoConfig.OnUnauthenticatedRequest=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.on_unauthenticated_request) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateCognitoConfig.Scope=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.scope) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateCognitoConfig.SessionCookieName=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.session_cookie_name) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateCognitoConfig.SessionTimeout=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.session_timeout) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateCognitoConfig.UserPoolArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.user_pool_arn);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateCognitoConfig.UserPoolClientId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.user_pool_client_id);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateCognitoConfig.UserPoolDomain=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.user_pool_domain);
                }
            }
            if (item.authenticate_oidc_config) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateOidcConfig.AuthorizationEndpoint=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.authorization_endpoint);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateOidcConfig.ClientId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.client_id);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateOidcConfig.ClientSecret=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.client_secret) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateOidcConfig.Issuer=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.issuer);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateOidcConfig.OnUnauthenticatedRequest=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.on_unauthenticated_request) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateOidcConfig.Scope=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.scope) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateOidcConfig.SessionCookieName=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.session_cookie_name) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateOidcConfig.SessionTimeout=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.session_timeout) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateOidcConfig.TokenEndpoint=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.token_endpoint);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateOidcConfig.UseExistingClientSecret=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.use_existing_client_secret) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateOidcConfig.UserInfoEndpoint=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.user_info_endpoint);
                }
            }
            if (item.fixed_response_config) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.FixedResponseConfig.ContentType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.content_type) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.FixedResponseConfig.MessageBody=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.message_body) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.FixedResponseConfig.StatusCode=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.status_code);
                }
            }
            if (item.forward_config) |sv_1| {
                if (sv_1.target_groups) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.ForwardConfig.TargetGroups.member.{d}.TargetGroupArn=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            if (item_2.target_group_arn) |fv_3| {
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.ForwardConfig.TargetGroups.member.{d}.Weight=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            if (item_2.weight) |fv_3| {
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                    }
                }
                if (sv_1.target_group_stickiness_config) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.ForwardConfig.TargetGroupStickinessConfig.DurationSeconds=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (sv_2.duration_seconds) |fv_3| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.ForwardConfig.TargetGroupStickinessConfig.Enabled=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (sv_2.enabled) |fv_3| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_3) "true" else "false");
                        }
                    }
                }
            }
            if (item.jwt_validation_config) |sv_1| {
                if (sv_1.additional_claims) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.JwtValidationConfig.AdditionalClaims.member.{d}.Format=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.format.wireName());
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.JwtValidationConfig.AdditionalClaims.member.{d}.Name=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.name);
                        }
                        for (item_2.values, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.JwtValidationConfig.AdditionalClaims.member.{d}.Values.member.{d}=", .{n, n_2, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.JwtValidationConfig.Issuer=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.issuer);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.JwtValidationConfig.JwksEndpoint=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.jwks_endpoint);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.Order=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.order) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            if (item.redirect_config) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.RedirectConfig.Host=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.host) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.RedirectConfig.Path=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.path) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.RedirectConfig.Port=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.port) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.RedirectConfig.Protocol=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.protocol) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.RedirectConfig.Query=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.query) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.RedirectConfig.StatusCode=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.status_code.wireName());
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.TargetGroupArn=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.target_group_arn) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.Type=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.@"type".wireName());
            }
        }
    }
    try body_buf.appendSlice(allocator, "&ListenerArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.listener_arn);
    if (input.mutual_authentication) |v| {
        if (v.advertise_trust_store_ca_names) |sv| {
            try body_buf.appendSlice(allocator, "&MutualAuthentication.AdvertiseTrustStoreCaNames=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.ignore_client_certificate_expiry) |sv| {
            try body_buf.appendSlice(allocator, "&MutualAuthentication.IgnoreClientCertificateExpiry=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
        if (v.mode) |sv| {
            try body_buf.appendSlice(allocator, "&MutualAuthentication.Mode=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.trust_store_arn) |sv| {
            try body_buf.appendSlice(allocator, "&MutualAuthentication.TrustStoreArn=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.trust_store_association_status) |sv| {
            try body_buf.appendSlice(allocator, "&MutualAuthentication.TrustStoreAssociationStatus=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
    }
    if (input.port) |v| {
        try body_buf.appendSlice(allocator, "&Port=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.protocol) |v| {
        try body_buf.appendSlice(allocator, "&Protocol=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.ssl_policy) |v| {
        try body_buf.appendSlice(allocator, "&SslPolicy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyListenerOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyListenerResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyListenerOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Listeners")) {
                    result.listeners = try serde.deserializeListeners(allocator, &reader, "member");
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
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AllocationIdNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .allocation_id_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ALPNPolicyNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .alpn_policy_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AvailabilityZoneNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .availability_zone_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CaCertificatesBundleNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .ca_certificates_bundle_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CapacityDecreaseRequestsLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .capacity_decrease_requests_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CapacityReservationPendingException")) {
        return .{ .arena = arena, .kind = .{ .capacity_reservation_pending_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CapacityUnitsLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .capacity_units_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CertificateNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .certificate_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DeleteAssociationSameAccountException")) {
        return .{ .arena = arena, .kind = .{ .delete_association_same_account_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateListenerException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_listener_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateLoadBalancerNameException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_load_balancer_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateTagKeysException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_tag_keys_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateTargetGroupNameException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_target_group_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateTrustStoreNameException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_trust_store_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HealthUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .health_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncompatibleProtocolsException")) {
        return .{ .arena = arena, .kind = .{ .incompatible_protocols_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientCapacityException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_capacity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCaCertificatesBundleException")) {
        return .{ .arena = arena, .kind = .{ .invalid_ca_certificates_bundle_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidConfigurationRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_configuration_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLoadBalancerActionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_load_balancer_action_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRevocationContentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_revocation_content_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSchemeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_scheme_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurityGroupException")) {
        return .{ .arena = arena, .kind = .{ .invalid_security_group_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnetException")) {
        return .{ .arena = arena, .kind = .{ .invalid_subnet_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetException")) {
        return .{ .arena = arena, .kind = .{ .invalid_target_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ListenerNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .listener_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LoadBalancerNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .load_balancer_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotPermittedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_permitted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PriorRequestNotCompleteException")) {
        return .{ .arena = arena, .kind = .{ .prior_request_not_complete_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PriorityInUseException")) {
        return .{ .arena = arena, .kind = .{ .priority_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RevocationContentNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .revocation_content_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RevocationIdNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .revocation_id_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RuleNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .rule_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SSLPolicyNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .ssl_policy_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .subnet_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TargetGroupAssociationLimitException")) {
        return .{ .arena = arena, .kind = .{ .target_group_association_limit_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TargetGroupNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .target_group_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyActionsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_actions_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyCertificatesException")) {
        return .{ .arena = arena, .kind = .{ .too_many_certificates_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyListenersException")) {
        return .{ .arena = arena, .kind = .{ .too_many_listeners_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyLoadBalancersException")) {
        return .{ .arena = arena, .kind = .{ .too_many_load_balancers_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRegistrationsForTargetIdException")) {
        return .{ .arena = arena, .kind = .{ .too_many_registrations_for_target_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRulesException")) {
        return .{ .arena = arena, .kind = .{ .too_many_rules_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTargetGroupsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_target_groups_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTargetsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_targets_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTrustStoreRevocationEntriesException")) {
        return .{ .arena = arena, .kind = .{ .too_many_trust_store_revocation_entries_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTrustStoresException")) {
        return .{ .arena = arena, .kind = .{ .too_many_trust_stores_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyUniqueTargetGroupsPerLoadBalancerException")) {
        return .{ .arena = arena, .kind = .{ .too_many_unique_target_groups_per_load_balancer_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrustStoreAssociationNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .trust_store_association_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrustStoreInUseException")) {
        return .{ .arena = arena, .kind = .{ .trust_store_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrustStoreNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .trust_store_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrustStoreNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .trust_store_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedProtocolException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_protocol_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
