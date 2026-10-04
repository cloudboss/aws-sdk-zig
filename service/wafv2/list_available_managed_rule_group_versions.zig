const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Scope = @import("scope.zig").Scope;
const ManagedRuleGroupVersion = @import("managed_rule_group_version.zig").ManagedRuleGroupVersion;

pub const ListAvailableManagedRuleGroupVersionsInput = struct {
    /// The maximum number of objects that you want WAF to return for this request.
    /// If more
    /// objects are available, in the response, WAF provides a
    /// `NextMarker` value that you can use in a subsequent call to get the next
    /// batch of objects.
    limit: ?i32 = null,

    /// The name of the managed rule group. You use this, along with the vendor
    /// name, to identify the rule group.
    name: []const u8,

    /// When you request a list of objects with a `Limit` setting, if the number of
    /// objects that are still available
    /// for retrieval exceeds the limit, WAF returns a `NextMarker`
    /// value in the response. To retrieve the next batch of objects, provide the
    /// marker from the prior call in your next request.
    next_marker: ?[]const u8 = null,

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

    /// The name of the managed rule group vendor. You use this, along with the rule
    /// group name, to identify a rule group.
    vendor_name: []const u8,

    pub const json_field_names = .{
        .limit = "Limit",
        .name = "Name",
        .next_marker = "NextMarker",
        .scope = "Scope",
        .vendor_name = "VendorName",
    };
};

pub const ListAvailableManagedRuleGroupVersionsOutput = struct {
    /// The name of the version that's currently set as the default.
    current_default_version: ?[]const u8 = null,

    /// When you request a list of objects with a `Limit` setting, if the number of
    /// objects that are still available
    /// for retrieval exceeds the limit, WAF returns a `NextMarker`
    /// value in the response. To retrieve the next batch of objects, provide the
    /// marker from the prior call in your next request.
    next_marker: ?[]const u8 = null,

    /// The versions that are currently available for the specified managed rule
    /// group. If you specified a `Limit` in your request, this might not be the
    /// full list.
    versions: ?[]const ManagedRuleGroupVersion = null,

    pub const json_field_names = .{
        .current_default_version = "CurrentDefaultVersion",
        .next_marker = "NextMarker",
        .versions = "Versions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAvailableManagedRuleGroupVersionsInput, options: CallOptions) !ListAvailableManagedRuleGroupVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAvailableManagedRuleGroupVersionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.ListAvailableManagedRuleGroupVersions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAvailableManagedRuleGroupVersionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAvailableManagedRuleGroupVersionsOutput, body, allocator);
}
