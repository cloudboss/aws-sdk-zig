const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Action = @import("action.zig").Action;
const RuleCondition = @import("rule_condition.zig").RuleCondition;
const RuleTransform = @import("rule_transform.zig").RuleTransform;
const Rule = @import("rule.zig").Rule;
const serde = @import("serde.zig");

pub const ModifyRuleInput = struct {
    /// The actions.
    actions: ?[]const Action = null,

    /// The conditions.
    conditions: ?[]const RuleCondition = null,

    /// Indicates whether to remove all transforms from the rule. If you specify
    /// `ResetTransforms`,
    /// you can't specify `Transforms`.
    reset_transforms: ?bool = null,

    /// The Amazon Resource Name (ARN) of the rule.
    rule_arn: []const u8,

    /// The transforms to apply to requests that match this rule. You can add one
    /// host header rewrite transform
    /// and one URL rewrite transform. If you specify `Transforms`, you can't
    /// specify `ResetTransforms`.
    transforms: ?[]const RuleTransform = null,
};

pub const ModifyRuleOutput = struct {
    /// Information about the modified rule.
    rules: ?[]const Rule = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyRuleInput, options: CallOptions) !ModifyRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing v2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyRule&Version=2015-12-01");
    if (input.actions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.authenticate_cognito_config) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.on_unauthenticated_request) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateCognitoConfig.OnUnauthenticatedRequest=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.scope) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateCognitoConfig.Scope=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.session_cookie_name) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateCognitoConfig.SessionCookieName=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.session_timeout) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateCognitoConfig.SessionTimeout=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateCognitoConfig.UserPoolArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.user_pool_arn);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateCognitoConfig.UserPoolClientId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.user_pool_client_id);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateCognitoConfig.UserPoolDomain=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.user_pool_domain);
                }
            }
            if (item.authenticate_oidc_config) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.AuthorizationEndpoint=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.authorization_endpoint);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.ClientId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.client_id);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.client_secret) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.ClientSecret=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.Issuer=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.issuer);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.on_unauthenticated_request) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.OnUnauthenticatedRequest=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.scope) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.Scope=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.session_cookie_name) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.SessionCookieName=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.session_timeout) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.SessionTimeout=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.TokenEndpoint=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.token_endpoint);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.use_existing_client_secret) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.UseExistingClientSecret=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.UserInfoEndpoint=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.user_info_endpoint);
                }
            }
            if (item.fixed_response_config) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.content_type) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.FixedResponseConfig.ContentType=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.message_body) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.FixedResponseConfig.MessageBody=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.FixedResponseConfig.StatusCode=", .{n}) catch continue;
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
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.ForwardConfig.TargetGroups.member.{d}.TargetGroupArn=", .{ n, n_2 }) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (item_2.weight) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.ForwardConfig.TargetGroups.member.{d}.Weight=", .{ n, n_2 }) catch continue;
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
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.ForwardConfig.TargetGroupStickinessConfig.DurationSeconds=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.enabled) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.ForwardConfig.TargetGroupStickinessConfig.Enabled=", .{n}) catch continue;
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
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.JwtValidationConfig.AdditionalClaims.member.{d}.Format=", .{ n, n_2 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.format.wireName());
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.JwtValidationConfig.AdditionalClaims.member.{d}.Name=", .{ n, n_2 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.name);
                        }
                        for (item_2.values, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.JwtValidationConfig.AdditionalClaims.member.{d}.Values.member.{d}=", .{ n, n_2, n_3 }) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.JwtValidationConfig.Issuer=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.issuer);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.JwtValidationConfig.JwksEndpoint=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.jwks_endpoint);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.order) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.Order=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            if (item.redirect_config) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.host) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.RedirectConfig.Host=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.path) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.RedirectConfig.Path=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.port) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.RedirectConfig.Port=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.protocol) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.RedirectConfig.Protocol=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.query) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.RedirectConfig.Query=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.RedirectConfig.StatusCode=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.status_code.wireName());
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.target_group_arn) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.TargetGroupArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.Type=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.type.wireName());
            }
        }
    }
    if (input.conditions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.field) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.Field=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.host_header_config) |sv_1| {
                if (sv_1.regex_values) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.HostHeaderConfig.RegexValues.member.{d}=", .{ n, n_2 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2);
                        }
                    }
                }
                if (sv_1.values) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.HostHeaderConfig.Values.member.{d}=", .{ n, n_2 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2);
                        }
                    }
                }
            }
            if (item.http_header_config) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.http_header_name) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.HttpHeaderConfig.HttpHeaderName=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                if (sv_1.regex_values) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.HttpHeaderConfig.RegexValues.member.{d}=", .{ n, n_2 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2);
                        }
                    }
                }
                if (sv_1.values) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.HttpHeaderConfig.Values.member.{d}=", .{ n, n_2 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2);
                        }
                    }
                }
            }
            if (item.http_request_method_config) |sv_1| {
                if (sv_1.values) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.HttpRequestMethodConfig.Values.member.{d}=", .{ n, n_2 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2);
                        }
                    }
                }
            }
            if (item.path_pattern_config) |sv_1| {
                if (sv_1.regex_values) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.PathPatternConfig.RegexValues.member.{d}=", .{ n, n_2 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2);
                        }
                    }
                }
                if (sv_1.values) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.PathPatternConfig.Values.member.{d}=", .{ n, n_2 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2);
                        }
                    }
                }
            }
            if (item.query_string_config) |sv_1| {
                if (sv_1.values) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (item_2.key) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.QueryStringConfig.Values.member.{d}.Key=", .{ n, n_2 }) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (item_2.value) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.QueryStringConfig.Values.member.{d}.Value=", .{ n, n_2 }) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                    }
                }
            }
            if (item.regex_values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.RegexValues.member.{d}=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
            if (item.source_ip_config) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.ip_address_type) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.SourceIpConfig.IpAddressType=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                    }
                }
                if (sv_1.values) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.SourceIpConfig.Values.member.{d}=", .{ n, n_2 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2);
                        }
                    }
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.Values.member.{d}=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.reset_transforms) |v| {
        try body_buf.appendSlice(allocator, "&ResetTransforms=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&RuleArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.rule_arn);
    if (input.transforms) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.host_header_rewrite_config) |sv_1| {
                if (sv_1.rewrites) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Transforms.member.{d}.HostHeaderRewriteConfig.Rewrites.member.{d}.Regex=", .{ n, n_2 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.regex);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Transforms.member.{d}.HostHeaderRewriteConfig.Rewrites.member.{d}.Replace=", .{ n, n_2 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.replace);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Transforms.member.{d}.Type=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.type.wireName());
            }
            if (item.url_rewrite_config) |sv_1| {
                if (sv_1.rewrites) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Transforms.member.{d}.UrlRewriteConfig.Rewrites.member.{d}.Regex=", .{ n, n_2 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.regex);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Transforms.member.{d}.UrlRewriteConfig.Rewrites.member.{d}.Replace=", .{ n, n_2 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.replace);
                        }
                    }
                }
            }
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyRuleOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyRuleResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyRuleOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Rules")) {
                    result.rules = try serde.deserializeRules(allocator, &reader, "member");
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
