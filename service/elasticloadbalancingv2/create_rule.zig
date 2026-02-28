const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Action = @import("action.zig").Action;
const RuleCondition = @import("rule_condition.zig").RuleCondition;
const Tag = @import("tag.zig").Tag;
const RuleTransform = @import("rule_transform.zig").RuleTransform;
const Rule = @import("rule.zig").Rule;
const serde = @import("serde.zig");

pub const CreateRuleInput = struct {
    /// The actions.
    actions: []const Action,

    /// The conditions.
    conditions: []const RuleCondition,

    /// The Amazon Resource Name (ARN) of the listener.
    listener_arn: []const u8,

    /// The rule priority. A listener can't have multiple rules with the same
    /// priority.
    priority: i32,

    /// The tags to assign to the rule.
    tags: ?[]const Tag = null,

    /// The transforms to apply to requests that match this rule. You can add one
    /// host header rewrite transform
    /// and one URL rewrite transform.
    transforms: ?[]const RuleTransform = null,
};

pub const CreateRuleOutput = struct {
    /// Information about the rule.
    rules: ?[]const Rule = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRuleInput, options: Options) !CreateRuleOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancingv2", "Elastic Load Balancing v2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateRule&Version=2015-12-01");
    for (input.actions, 0..) |item, idx| {
        const n = idx + 1;
        if (item.authenticate_cognito_config) |sv_1| {
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateCognitoConfig.OnUnauthenticatedRequest=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.on_unauthenticated_request) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_2));
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateCognitoConfig.Scope=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.scope) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateCognitoConfig.SessionCookieName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.session_cookie_name) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateCognitoConfig.SessionTimeout=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.session_timeout) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateCognitoConfig.UserPoolArn=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv_1.user_pool_arn);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateCognitoConfig.UserPoolClientId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv_1.user_pool_client_id);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateCognitoConfig.UserPoolDomain=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv_1.user_pool_domain);
            }
        }
        if (item.authenticate_oidc_config) |sv_1| {
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.AuthorizationEndpoint=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv_1.authorization_endpoint);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.ClientId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv_1.client_id);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.ClientSecret=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.client_secret) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.Issuer=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv_1.issuer);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.OnUnauthenticatedRequest=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.on_unauthenticated_request) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_2));
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.Scope=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.scope) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.SessionCookieName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.session_cookie_name) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.SessionTimeout=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.session_timeout) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.TokenEndpoint=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv_1.token_endpoint);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.UseExistingClientSecret=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.use_existing_client_secret) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.AuthenticateOidcConfig.UserInfoEndpoint=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv_1.user_info_endpoint);
            }
        }
        if (item.fixed_response_config) |sv_1| {
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.FixedResponseConfig.ContentType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.content_type) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.FixedResponseConfig.MessageBody=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.message_body) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.FixedResponseConfig.StatusCode=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv_1.status_code);
            }
        }
        if (item.forward_config) |sv_1| {
            if (sv_1.target_groups) |lst_2| {
                for (lst_2, 0..) |item_2, idx_2| {
                    const n_2 = idx_2 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.ForwardConfig.TargetGroups.member.{d}.TargetGroupArn=", .{ n, n_2 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_2.target_group_arn) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.ForwardConfig.TargetGroups.member.{d}.Weight=", .{ n, n_2 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_2.weight) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                        }
                    }
                }
            }
            if (sv_1.target_group_stickiness_config) |sv_2| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.ForwardConfig.TargetGroupStickinessConfig.DurationSeconds=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_2.duration_seconds) |fv_3| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.ForwardConfig.TargetGroupStickinessConfig.Enabled=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_2.enabled) |fv_3| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_3) "true" else "false");
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
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(item_2.format));
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.JwtValidationConfig.AdditionalClaims.member.{d}.Name=", .{ n, n_2 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_2.name);
                    }
                    for (item_2.values, 0..) |item_3, idx_3| {
                        const n_3 = idx_3 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.JwtValidationConfig.AdditionalClaims.member.{d}.Values.member.{d}=", .{ n, n_2, n_3 }) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.JwtValidationConfig.Issuer=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv_1.issuer);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.JwtValidationConfig.JwksEndpoint=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv_1.jwks_endpoint);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.Order=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.order) |fv_1| {
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
            }
        }
        if (item.redirect_config) |sv_1| {
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.RedirectConfig.Host=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.host) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.RedirectConfig.Path=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.path) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.RedirectConfig.Port=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.port) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.RedirectConfig.Protocol=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.protocol) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.RedirectConfig.Query=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.query) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.RedirectConfig.StatusCode=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv_1.status_code));
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.TargetGroupArn=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.target_group_arn) |fv_1| {
                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Actions.member.{d}.Type=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(item.type));
        }
    }
    for (input.conditions, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.Field=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.field) |fv_1| {
                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
            }
        }
        if (item.host_header_config) |sv_1| {
            if (sv_1.regex_values) |lst_2| {
                for (lst_2, 0..) |item_2, idx_2| {
                    const n_2 = idx_2 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.HostHeaderConfig.RegexValues.member.{d}=", .{ n, n_2 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
                    }
                }
            }
            if (sv_1.values) |lst_2| {
                for (lst_2, 0..) |item_2, idx_2| {
                    const n_2 = idx_2 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.HostHeaderConfig.Values.member.{d}=", .{ n, n_2 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
                    }
                }
            }
        }
        if (item.http_header_config) |sv_1| {
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.HttpHeaderConfig.HttpHeaderName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (sv_1.http_header_name) |fv_2| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                }
            }
            if (sv_1.regex_values) |lst_2| {
                for (lst_2, 0..) |item_2, idx_2| {
                    const n_2 = idx_2 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.HttpHeaderConfig.RegexValues.member.{d}=", .{ n, n_2 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
                    }
                }
            }
            if (sv_1.values) |lst_2| {
                for (lst_2, 0..) |item_2, idx_2| {
                    const n_2 = idx_2 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.HttpHeaderConfig.Values.member.{d}=", .{ n, n_2 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
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
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
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
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
                    }
                }
            }
            if (sv_1.values) |lst_2| {
                for (lst_2, 0..) |item_2, idx_2| {
                    const n_2 = idx_2 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.PathPatternConfig.Values.member.{d}=", .{ n, n_2 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.QueryStringConfig.Values.member.{d}.Key=", .{ n, n_2 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_2.key) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.QueryStringConfig.Values.member.{d}.Value=", .{ n, n_2 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_2.value) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
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
                    try body_buf.appendSlice(alloc, field_prefix);
                    try aws.url.appendUrlEncoded(alloc, &body_buf, item_1);
                }
            }
        }
        if (item.source_ip_config) |sv_1| {
            if (sv_1.values) |lst_2| {
                for (lst_2, 0..) |item_2, idx_2| {
                    const n_2 = idx_2 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Conditions.member.{d}.SourceIpConfig.Values.member.{d}=", .{ n, n_2 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
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
                    try body_buf.appendSlice(alloc, field_prefix);
                    try aws.url.appendUrlEncoded(alloc, &body_buf, item_1);
                }
            }
        }
    }
    try body_buf.appendSlice(alloc, "&ListenerArn=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.listener_arn);
    try body_buf.appendSlice(alloc, "&Priority=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.priority}) catch "");
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
    }
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
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, item_2.regex);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Transforms.member.{d}.HostHeaderRewriteConfig.Rewrites.member.{d}.Replace=", .{ n, n_2 }) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, item_2.replace);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Transforms.member.{d}.Type=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(item.type));
            }
            if (item.url_rewrite_config) |sv_1| {
                if (sv_1.rewrites) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Transforms.member.{d}.UrlRewriteConfig.Rewrites.member.{d}.Regex=", .{ n, n_2 }) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, item_2.regex);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Transforms.member.{d}.UrlRewriteConfig.Rewrites.member.{d}.Replace=", .{ n, n_2 }) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, item_2.replace);
                        }
                    }
                }
            }
        }
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateRuleOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateRuleResult")) break;
            },
            else => {},
        }
    }

    var result: CreateRuleOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Rules")) {
                    result.rules = try serde.deserializeRules(&reader, alloc, "member");
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
