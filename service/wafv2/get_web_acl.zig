const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Scope = @import("scope.zig").Scope;
const WebACL = @import("web_acl.zig").WebACL;

pub const GetWebACLInput = struct {
    /// The Amazon Resource Name (ARN) of the web ACL that you want to retrieve.
    arn: ?[]const u8 = null,

    /// The unique identifier for the web ACL. This ID is returned in the responses
    /// to create and list commands. You provide it to operations like update and
    /// delete.
    id: ?[]const u8 = null,

    /// The name of the web ACL. You cannot change the name of a web ACL after you
    /// create it.
    name: ?[]const u8 = null,

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
    scope: ?Scope = null,

    pub const json_field_names = .{
        .arn = "ARN",
        .id = "Id",
        .name = "Name",
        .scope = "Scope",
    };
};

pub const GetWebACLOutput = struct {
    /// The URL to use in SDK integrations with Amazon Web Services managed rule
    /// groups. For example, you can use the integration SDKs with the account
    /// takeover prevention managed rule group `AWSManagedRulesATPRuleSet` and the
    /// account creation fraud prevention managed rule group
    /// `AWSManagedRulesACFPRuleSet`. This is only populated if you are using a rule
    /// group in your web ACL that integrates with your applications in this way.
    /// For more information, see [WAF client application
    /// integration](https://docs.aws.amazon.com/waf/latest/developerguide/waf-application-integration.html)
    /// in the *WAF Developer Guide*.
    application_integration_url: ?[]const u8 = null,

    /// A token used for optimistic locking. WAF returns a token to your `get` and
    /// `list` requests, to mark the state of the entity at the time of the request.
    /// To make changes to the entity associated with the token, you provide the
    /// token to operations like `update` and `delete`. WAF uses the token to ensure
    /// that no changes have been made to the entity since you last retrieved it. If
    /// a change has been made, the update fails with a
    /// `WAFOptimisticLockException`. If this happens, perform another `get`, and
    /// use the new token returned by that operation.
    lock_token: ?[]const u8 = null,

    /// The web ACL specification. You can modify the settings in this web ACL and
    /// use it to
    /// update this web ACL or create a new one.
    web_acl: ?WebACL = null,

    pub const json_field_names = .{
        .application_integration_url = "ApplicationIntegrationURL",
        .lock_token = "LockToken",
        .web_acl = "WebACL",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWebACLInput, options: CallOptions) !GetWebACLOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWebACLInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.GetWebACL");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWebACLOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetWebACLOutput, body, allocator);
}
