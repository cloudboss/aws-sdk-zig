const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceType = @import("resource_type.zig").ResourceType;

pub const ListResourcesForWebACLInput = struct {
    /// Retrieves the web ACLs that are used by the specified resource type.
    ///
    /// For Amazon CloudFront, don't use this call. Instead, use the CloudFront call
    /// `ListDistributionsByWebACLId`. For information, see
    /// [ListDistributionsByWebACLId](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_ListDistributionsByWebACLId.html)
    /// in the *Amazon CloudFront API Reference*.
    ///
    /// If you don't provide a resource type, the call uses the resource type
    /// `APPLICATION_LOAD_BALANCER`.
    ///
    /// Default: `APPLICATION_LOAD_BALANCER`
    resource_type: ?ResourceType = null,

    /// The Amazon Resource Name (ARN) of the web ACL.
    web_acl_arn: []const u8,

    pub const json_field_names = .{
        .resource_type = "ResourceType",
        .web_acl_arn = "WebACLArn",
    };
};

pub const ListResourcesForWebACLOutput = struct {
    /// The array of Amazon Resource Names (ARNs) of the associated resources.
    resource_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .resource_arns = "ResourceArns",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourcesForWebACLInput, options: CallOptions) !ListResourcesForWebACLOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourcesForWebACLInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.ListResourcesForWebACL");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourcesForWebACLOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListResourcesForWebACLOutput, body, allocator);
}
