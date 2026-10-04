const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomResponseBody = @import("custom_response_body.zig").CustomResponseBody;
const Rule = @import("rule.zig").Rule;
const Scope = @import("scope.zig").Scope;
const VisibilityConfig = @import("visibility_config.zig").VisibilityConfig;

pub const UpdateRuleGroupInput = struct {
    /// A map of custom response keys and content bodies. When you create a rule
    /// with a block action, you can send a custom response to the web request. You
    /// define these for the rule group, and then use them in the rules that you
    /// define in the rule group.
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

    /// A description of the rule group that helps with identification.
    description: ?[]const u8 = null,

    /// A unique identifier for the rule group. This ID is returned in the responses
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

    /// The name of the rule group. You cannot change the name of a rule group after
    /// you create it.
    name: []const u8,

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

    /// Defines and enables Amazon CloudWatch metrics and web request sample
    /// collection.
    visibility_config: VisibilityConfig,

    pub const json_field_names = .{
        .custom_response_bodies = "CustomResponseBodies",
        .description = "Description",
        .id = "Id",
        .lock_token = "LockToken",
        .name = "Name",
        .rules = "Rules",
        .scope = "Scope",
        .visibility_config = "VisibilityConfig",
    };
};

pub const UpdateRuleGroupOutput = struct {
    /// A token used for optimistic locking. WAF returns this token to your `update`
    /// requests. You use `NextLockToken` in the same manner as you use `LockToken`.
    next_lock_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_lock_token = "NextLockToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRuleGroupInput, options: CallOptions) !UpdateRuleGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wafv2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRuleGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wafv2", "WAFV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.UpdateRuleGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRuleGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateRuleGroupOutput, body, allocator);
}
