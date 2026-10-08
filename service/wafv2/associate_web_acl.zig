const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateWebACLInput = struct {
    /// The Amazon Resource Name (ARN) of the resource to associate with the web
    /// ACL.
    ///
    /// The ARN must be in one of the following formats:
    ///
    /// * For an Application Load Balancer:
    ///   `arn:*partition*:elasticloadbalancing:*region*:*account-id*:loadbalancer/app/*load-balancer-name*/*load-balancer-id*
    /// `
    ///
    /// * For an Amazon API Gateway REST API:
    ///   `arn:*partition*:apigateway:*region*::/restapis/*api-id*/stages/*stage-name*
    /// `
    ///
    /// * For an AppSync GraphQL API:
    ///   `arn:*partition*:appsync:*region*:*account-id*:apis/*GraphQLApiId*
    /// `
    ///
    /// * For an Amazon Cognito user pool:
    ///   `arn:*partition*:cognito-idp:*region*:*account-id*:userpool/*user-pool-id*
    /// `
    ///
    /// * For an App Runner service:
    ///   `arn:*partition*:apprunner:*region*:*account-id*:service/*apprunner-service-name*/*apprunner-service-id*
    /// `
    ///
    /// * For an Amazon Web Services Verified Access instance:
    ///   `arn:*partition*:ec2:*region*:*account-id*:verified-access-instance/*instance-id*
    /// `
    ///
    /// * For an Amplify application:
    ///   `arn:*partition*:amplify:*region*:*account-id*:apps/*app-id*
    /// `
    ///
    /// * For an Amazon Bedrock AgentCore Gateway:
    ///   `arn:*partition*:bedrock-agentcore:*region*:*account-id*:gateway/*gateway-id*
    /// `
    resource_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the web ACL that you want to associate
    /// with the
    /// resource.
    web_acl_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .web_acl_arn = "WebACLArn",
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateWebACLInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.AssociateWebACL");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateWebACLOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
