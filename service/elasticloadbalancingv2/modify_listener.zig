const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticloadbalancing", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyListenerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing v2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

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
                if (item.certificate_arn) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Certificates.member.{d}.CertificateArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.is_default) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Certificates.member.{d}.IsDefault=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
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
                    if (sv_1.on_unauthenticated_request) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateCognitoConfig.OnUnauthenticatedRequest=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.scope) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateCognitoConfig.Scope=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.session_cookie_name) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateCognitoConfig.SessionCookieName=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.session_timeout) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateCognitoConfig.SessionTimeout=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
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
                    if (sv_1.client_secret) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateOidcConfig.ClientSecret=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
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
                    if (sv_1.on_unauthenticated_request) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateOidcConfig.OnUnauthenticatedRequest=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.scope) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateOidcConfig.Scope=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.session_cookie_name) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateOidcConfig.SessionCookieName=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.session_timeout) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateOidcConfig.SessionTimeout=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
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
                    if (sv_1.use_existing_client_secret) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.AuthenticateOidcConfig.UseExistingClientSecret=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
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
                    if (sv_1.content_type) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.FixedResponseConfig.ContentType=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.message_body) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.FixedResponseConfig.MessageBody=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
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
                            if (item_2.target_group_arn) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.ForwardConfig.TargetGroups.member.{d}.TargetGroupArn=", .{n, n_2}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (item_2.weight) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.ForwardConfig.TargetGroups.member.{d}.Weight=", .{n, n_2}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                    }
                }
                if (sv_1.target_group_stickiness_config) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.duration_seconds) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.ForwardConfig.TargetGroupStickinessConfig.DurationSeconds=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.enabled) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.ForwardConfig.TargetGroupStickinessConfig.Enabled=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
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
                if (item.order) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.Order=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            if (item.redirect_config) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.host) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.RedirectConfig.Host=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.path) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.RedirectConfig.Path=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.port) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.RedirectConfig.Port=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.protocol) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.RedirectConfig.Protocol=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.query) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.RedirectConfig.Query=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
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
                if (item.target_group_arn) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DefaultActions.member.{d}.TargetGroupArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
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
