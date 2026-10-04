const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RiskConfigurationType = @import("risk_configuration_type.zig").RiskConfigurationType;

pub const DescribeRiskConfigurationInput = struct {
    /// The ID of the app client with the risk configuration that you want to
    /// inspect. You can
    /// apply default risk configuration at the user pool level and further
    /// customize it from
    /// user pool defaults at the app-client level. Specify `ClientId` to inspect
    /// client-level configuration, or `UserPoolId` to inspect pool-level
    /// configuration.
    client_id: ?[]const u8 = null,

    /// The ID of the user pool with the risk configuration that you want to
    /// inspect. You can
    /// apply default risk configuration at the user pool level and further
    /// customize it from
    /// user pool defaults at the app-client level. Specify `ClientId` to inspect
    /// client-level configuration, or `UserPoolId` to inspect pool-level
    /// configuration.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .user_pool_id = "UserPoolId",
    };
};

pub const DescribeRiskConfigurationOutput = struct {
    /// The details of the requested risk configuration.
    risk_configuration: ?RiskConfigurationType = null,

    pub const json_field_names = .{
        .risk_configuration = "RiskConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRiskConfigurationInput, options: CallOptions) !DescribeRiskConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-idp", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRiskConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-idp", "Cognito Identity Provider", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.DescribeRiskConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRiskConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeRiskConfigurationOutput, body, allocator);
}
