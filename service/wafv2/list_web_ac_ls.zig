const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Scope = @import("scope.zig").Scope;
const WebACLSummary = @import("web_acl_summary.zig").WebACLSummary;

pub const ListWebACLsInput = struct {
    /// The maximum number of objects that you want WAF to return for this request.
    /// If more
    /// objects are available, in the response, WAF provides a
    /// `NextMarker` value that you can use in a subsequent call to get the next
    /// batch of objects.
    limit: ?i32 = null,

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

    pub const json_field_names = .{
        .limit = "Limit",
        .next_marker = "NextMarker",
        .scope = "Scope",
    };
};

pub const ListWebACLsOutput = struct {
    /// When you request a list of objects with a `Limit` setting, if the number of
    /// objects that are still available
    /// for retrieval exceeds the limit, WAF returns a `NextMarker`
    /// value in the response. To retrieve the next batch of objects, provide the
    /// marker from the prior call in your next request.
    next_marker: ?[]const u8 = null,

    /// Array of web ACLs. If you specified a `Limit` in your request, this might
    /// not be the full list.
    web_ac_ls: ?[]const WebACLSummary = null,

    pub const json_field_names = .{
        .next_marker = "NextMarker",
        .web_ac_ls = "WebACLs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWebACLsInput, options: CallOptions) !ListWebACLsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWebACLsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.ListWebACLs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWebACLsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListWebACLsOutput, body, allocator);
}
