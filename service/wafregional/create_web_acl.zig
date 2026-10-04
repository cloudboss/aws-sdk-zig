const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WafAction = @import("waf_action.zig").WafAction;
const Tag = @import("tag.zig").Tag;
const WebACL = @import("web_acl.zig").WebACL;

pub const CreateWebACLInput = struct {
    /// The value returned by the most recent call to GetChangeToken.
    change_token: []const u8,

    /// The action that you want AWS WAF to take when a request doesn't match the
    /// criteria specified in any of the `Rule`
    /// objects that are associated with the `WebACL`.
    default_action: WafAction,

    /// A friendly name or description for the metrics for this `WebACL`.The name
    /// can contain only alphanumeric characters (A-Z, a-z, 0-9), with maximum
    /// length 128 and minimum length one. It can't contain
    /// whitespace or metric names reserved for AWS WAF, including "All" and
    /// "Default_Action." You can't change `MetricName` after you create the
    /// `WebACL`.
    metric_name: []const u8,

    /// A friendly name or description of the WebACL. You can't change `Name` after
    /// you create the `WebACL`.
    name: []const u8,

    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .change_token = "ChangeToken",
        .default_action = "DefaultAction",
        .metric_name = "MetricName",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateWebACLOutput = struct {
    /// The `ChangeToken` that you used to submit the `CreateWebACL` request. You
    /// can also use this value
    /// to query the status of the request. For more information, see
    /// GetChangeTokenStatus.
    change_token: ?[]const u8 = null,

    /// The WebACL returned in the `CreateWebACL` response.
    web_acl: ?WebACL = null,

    pub const json_field_names = .{
        .change_token = "ChangeToken",
        .web_acl = "WebACL",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWebACLInput, options: CallOptions) !CreateWebACLOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "waf-regional", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWebACLInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("waf-regional", "WAF Regional", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_Regional_20161128.CreateWebACL");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWebACLOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateWebACLOutput, body, allocator);
}
