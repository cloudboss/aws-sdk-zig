const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteFirewallManagerRuleGroupsInput = struct {
    /// The Amazon Resource Name (ARN) of the web ACL.
    web_acl_arn: []const u8,

    /// A token used for optimistic locking. WAF returns a token to your `get` and
    /// `list` requests, to mark the state of the entity at the time of the request.
    /// To make changes to the entity associated with the token, you provide the
    /// token to operations like `update` and `delete`. WAF uses the token to ensure
    /// that no changes have been made to the entity since you last retrieved it. If
    /// a change has been made, the update fails with a
    /// `WAFOptimisticLockException`. If this happens, perform another `get`, and
    /// use the new token returned by that operation.
    web_acl_lock_token: []const u8,

    pub const json_field_names = .{
        .web_acl_arn = "WebACLArn",
        .web_acl_lock_token = "WebACLLockToken",
    };
};

pub const DeleteFirewallManagerRuleGroupsOutput = struct {
    /// A token used for optimistic locking. WAF returns a token to your `get` and
    /// `list` requests, to mark the state of the entity at the time of the request.
    /// To make changes to the entity associated with the token, you provide the
    /// token to operations like `update` and `delete`. WAF uses the token to ensure
    /// that no changes have been made to the entity since you last retrieved it. If
    /// a change has been made, the update fails with a
    /// `WAFOptimisticLockException`. If this happens, perform another `get`, and
    /// use the new token returned by that operation.
    next_web_acl_lock_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_web_acl_lock_token = "NextWebACLLockToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteFirewallManagerRuleGroupsInput, options: CallOptions) !DeleteFirewallManagerRuleGroupsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteFirewallManagerRuleGroupsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.DeleteFirewallManagerRuleGroups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteFirewallManagerRuleGroupsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteFirewallManagerRuleGroupsOutput, body, allocator);
}
