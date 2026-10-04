const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Scope = @import("scope.zig").Scope;
const ManagedRuleSet = @import("managed_rule_set.zig").ManagedRuleSet;

pub const GetManagedRuleSetInput = struct {
    /// A unique identifier for the managed rule set. The ID is returned in the
    /// responses to commands like `list`. You provide it to operations like `get`
    /// and `update`.
    id: []const u8,

    /// The name of the managed rule set. You use this, along with the rule set ID,
    /// to identify the rule set.
    ///
    /// This name is assigned to the corresponding managed rule group, which your
    /// customers can access and use.
    name: []const u8,

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

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
        .scope = "Scope",
    };
};

pub const GetManagedRuleSetOutput = struct {
    /// A token used for optimistic locking. WAF returns a token to your `get` and
    /// `list` requests, to mark the state of the entity at the time of the request.
    /// To make changes to the entity associated with the token, you provide the
    /// token to operations like `update` and `delete`. WAF uses the token to ensure
    /// that no changes have been made to the entity since you last retrieved it. If
    /// a change has been made, the update fails with a
    /// `WAFOptimisticLockException`. If this happens, perform another `get`, and
    /// use the new token returned by that operation.
    lock_token: ?[]const u8 = null,

    /// The managed rule set that you requested.
    managed_rule_set: ?ManagedRuleSet = null,

    pub const json_field_names = .{
        .lock_token = "LockToken",
        .managed_rule_set = "ManagedRuleSet",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetManagedRuleSetInput, options: CallOptions) !GetManagedRuleSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetManagedRuleSetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.GetManagedRuleSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetManagedRuleSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetManagedRuleSetOutput, body, allocator);
}
