const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateWebACLInput = struct {
    /// The ARN (Amazon Resource Name) of the resource to be protected, either an
    /// application load balancer or Amazon API Gateway stage.
    ///
    /// The ARN should be in one of the following formats:
    ///
    /// * For an Application Load Balancer:
    ///   `arn:aws:elasticloadbalancing:*region*:*account-id*:loadbalancer/app/*load-balancer-name*/*load-balancer-id*
    /// `
    ///
    /// * For an Amazon API Gateway stage:
    ///   `arn:aws:apigateway:*region*::/restapis/*api-id*/stages/*stage-name*
    /// `
    resource_arn: []const u8,

    /// A unique identifier (ID) for the web ACL.
    web_acl_id: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .web_acl_id = "WebACLId",
    };
};

pub const AssociateWebACLOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateWebACLInput, options: CallOptions) !AssociateWebACLOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateWebACLInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_Regional_20161128.AssociateWebACL");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateWebACLOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
