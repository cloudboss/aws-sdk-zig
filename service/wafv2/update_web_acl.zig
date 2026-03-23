const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ApplicationConfig = @import("application_config.zig").ApplicationConfig;
const AssociationConfig = @import("association_config.zig").AssociationConfig;
const CaptchaConfig = @import("captcha_config.zig").CaptchaConfig;
const ChallengeConfig = @import("challenge_config.zig").ChallengeConfig;
const CustomResponseBody = @import("custom_response_body.zig").CustomResponseBody;
const DataProtectionConfig = @import("data_protection_config.zig").DataProtectionConfig;
const DefaultAction = @import("default_action.zig").DefaultAction;
const OnSourceDDoSProtectionConfig = @import("on_source_d_do_s_protection_config.zig").OnSourceDDoSProtectionConfig;
const Rule = @import("rule.zig").Rule;
const Scope = @import("scope.zig").Scope;
const VisibilityConfig = @import("visibility_config.zig").VisibilityConfig;

pub const UpdateWebACLInput = struct {
    /// Configures the ability for the WAF console to store and retrieve application
    /// attributes.
    /// Application attributes help WAF give recommendations for protection packs.
    ///
    /// When using `UpdateWebACL`, `ApplicationConfig` follows these rules:
    ///
    /// * If you omit `ApplicationConfig` from the request, all existing entries in
    ///   the web ACL are retained.
    ///
    /// * If you include `ApplicationConfig`, entries must match the existing values
    ///   exactly. Any attempt to modify existing entries will result in an error.
    application_config: ?ApplicationConfig = null,

    /// Specifies custom configurations for the associations between the web ACL and
    /// protected resources.
    ///
    /// Use this to customize the maximum size of the request body that your
    /// protected resources forward to WAF for inspection. You can
    /// customize this setting for CloudFront, API Gateway, Amazon Cognito, App
    /// Runner, or Verified Access resources. The default setting is 16 KB (16,384
    /// bytes).
    ///
    /// You are charged additional fees when your protected resources forward body
    /// sizes that are larger than the default. For more information, see [WAF
    /// Pricing](http://aws.amazon.com/waf/pricing/).
    ///
    /// For Application Load Balancer and AppSync, the limit is fixed at 8 KB (8,192
    /// bytes).
    association_config: ?AssociationConfig = null,

    /// Specifies how WAF should handle `CAPTCHA` evaluations for rules that don't
    /// have their own `CaptchaConfig` settings. If you don't specify this, WAF uses
    /// its default settings for `CaptchaConfig`.
    captcha_config: ?CaptchaConfig = null,

    /// Specifies how WAF should handle challenge evaluations for rules that don't
    /// have
    /// their own `ChallengeConfig` settings. If you don't specify this, WAF uses
    /// its default settings for `ChallengeConfig`.
    challenge_config: ?ChallengeConfig = null,

    /// A map of custom response keys and content bodies. When you create a rule
    /// with a block action, you can send a custom response to the web request. You
    /// define these for the web ACL, and then use them in the rules and default
    /// actions that you define in the web ACL.
    ///
    /// For information about customizing web requests and responses,
    /// see [Customizing web requests and responses in
    /// WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-custom-request-response.html)
    /// in the *WAF Developer Guide*.
    ///
    /// For information about the limits on count and size for custom request and
    /// response settings, see [WAF
    /// quotas](https://docs.aws.amazon.com/waf/latest/developerguide/limits.html)
    /// in the *WAF Developer Guide*.
    custom_response_bodies: ?[]const aws.map.MapEntry(CustomResponseBody) = null,

    /// Specifies data protection to apply to the web request data for the web ACL.
    /// This is a web ACL level data protection option.
    ///
    /// The data protection that you configure for the web ACL alters the data
    /// that's available for any other data collection activity,
    /// including your WAF logging destinations, web ACL request sampling, and
    /// Amazon Security Lake data collection and management. Your other option for
    /// data protection is in the logging configuration, which only affects logging.
    data_protection_config: ?DataProtectionConfig = null,

    /// The action to perform if none of the `Rules` contained in the `WebACL`
    /// match.
    default_action: DefaultAction,

    /// A description of the web ACL that helps with identification.
    description: ?[]const u8 = null,

    /// The unique identifier for the web ACL. This ID is returned in the responses
    /// to create and list commands. You provide it to operations like update and
    /// delete.
    id: []const u8,

    /// A token used for optimistic locking. WAF returns a token to your `get` and
    /// `list` requests, to mark the state of the entity at the time of the request.
    /// To make changes to the entity associated with the token, you provide the
    /// token to operations like `update` and `delete`. WAF uses the token to ensure
    /// that no changes have been made to the entity since you last retrieved it. If
    /// a change has been made, the update fails with a
    /// `WAFOptimisticLockException`. If this happens, perform another `get`, and
    /// use the new token returned by that operation.
    lock_token: []const u8,

    /// The name of the web ACL. You cannot change the name of a web ACL after you
    /// create it.
    name: []const u8,

    /// Specifies the type of DDoS protection to apply to web request data for a web
    /// ACL. For most scenarios, it is recommended to use the default protection
    /// level, `ACTIVE_UNDER_DDOS`.
    /// If a web ACL is associated with multiple Application Load Balancers, the
    /// changes you make to DDoS protection in that web ACL will apply to all
    /// associated Application Load Balancers.
    on_source_d_do_s_protection_config: ?OnSourceDDoSProtectionConfig = null,

    /// The Rule statements used to identify the web requests that you
    /// want to manage. Each rule includes one top-level statement that WAF uses to
    /// identify matching
    /// web requests, and parameters that govern how WAF handles them.
    rules: ?[]const Rule = null,

    /// Specifies whether this is for a global resource type, such as a Amazon
    /// CloudFront distribution. For an Amplify application, use `CLOUDFRONT`.
    ///
    /// To work with CloudFront, you must also specify the Region US East (N.
    /// Virginia) as follows:
    ///
    /// * CLI - Specify the Region when you use the CloudFront scope:
    ///   `--scope=CLOUDFRONT --region=us-east-1`.
    ///
    /// * API and SDKs - For all calls, use the Region endpoint us-east-1.
    scope: Scope,

    /// Specifies the domains that WAF should accept in a web request token. This
    /// enables the use of tokens across multiple protected websites. When WAF
    /// provides a token, it uses the domain of the Amazon Web Services resource
    /// that the web ACL is protecting. If you don't specify a list of token
    /// domains, WAF accepts tokens only for the domain of the protected resource.
    /// With a token domain list, WAF accepts the resource's host domain plus all
    /// domains in the token domain list, including their prefixed subdomains.
    ///
    /// Example JSON: `"TokenDomains": { "mywebsite.com", "myotherwebsite.com" }`
    ///
    /// Public suffixes aren't allowed. For example, you can't use `gov.au` or
    /// `co.uk` as token domains.
    token_domains: ?[]const []const u8 = null,

    /// Defines and enables Amazon CloudWatch metrics and web request sample
    /// collection.
    visibility_config: VisibilityConfig,

    pub const json_field_names = .{
        .application_config = "ApplicationConfig",
        .association_config = "AssociationConfig",
        .captcha_config = "CaptchaConfig",
        .challenge_config = "ChallengeConfig",
        .custom_response_bodies = "CustomResponseBodies",
        .data_protection_config = "DataProtectionConfig",
        .default_action = "DefaultAction",
        .description = "Description",
        .id = "Id",
        .lock_token = "LockToken",
        .name = "Name",
        .on_source_d_do_s_protection_config = "OnSourceDDoSProtectionConfig",
        .rules = "Rules",
        .scope = "Scope",
        .token_domains = "TokenDomains",
        .visibility_config = "VisibilityConfig",
    };
};

pub const UpdateWebACLOutput = struct {
    /// A token used for optimistic locking. WAF returns this token to your `update`
    /// requests. You use `NextLockToken` in the same manner as you use `LockToken`.
    next_lock_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_lock_token = "NextLockToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWebACLInput, options: CallOptions) !UpdateWebACLOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "wafv2");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWebACLInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wafv2", "WAFV2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.UpdateWebACL");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWebACLOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateWebACLOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "WAFAssociatedItemException")) {
        return .{ .arena = arena, .kind = .{ .waf_associated_item_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFConfigurationWarningException")) {
        return .{ .arena = arena, .kind = .{ .waf_configuration_warning_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFDuplicateItemException")) {
        return .{ .arena = arena, .kind = .{ .waf_duplicate_item_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFExpiredManagedRuleGroupVersionException")) {
        return .{ .arena = arena, .kind = .{ .waf_expired_managed_rule_group_version_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFFeatureNotIncludedInPricingPlanException")) {
        return .{ .arena = arena, .kind = .{ .waf_feature_not_included_in_pricing_plan_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFInternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .waf_internal_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFInvalidOperationException")) {
        return .{ .arena = arena, .kind = .{ .waf_invalid_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFInvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .waf_invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFInvalidPermissionPolicyException")) {
        return .{ .arena = arena, .kind = .{ .waf_invalid_permission_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFInvalidResourceException")) {
        return .{ .arena = arena, .kind = .{ .waf_invalid_resource_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFLimitsExceededException")) {
        return .{ .arena = arena, .kind = .{ .waf_limits_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFLogDestinationPermissionIssueException")) {
        return .{ .arena = arena, .kind = .{ .waf_log_destination_permission_issue_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFNonexistentItemException")) {
        return .{ .arena = arena, .kind = .{ .waf_nonexistent_item_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFOptimisticLockException")) {
        return .{ .arena = arena, .kind = .{ .waf_optimistic_lock_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFServiceLinkedRoleErrorException")) {
        return .{ .arena = arena, .kind = .{ .waf_service_linked_role_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFSubscriptionNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .waf_subscription_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFTagOperationException")) {
        return .{ .arena = arena, .kind = .{ .waf_tag_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFTagOperationInternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .waf_tag_operation_internal_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFUnavailableEntityException")) {
        return .{ .arena = arena, .kind = .{ .waf_unavailable_entity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFUnsupportedAggregateKeyTypeException")) {
        return .{ .arena = arena, .kind = .{ .waf_unsupported_aggregate_key_type_exception = .{
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
