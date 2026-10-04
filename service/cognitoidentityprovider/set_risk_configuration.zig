const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountTakeoverRiskConfigurationType = @import("account_takeover_risk_configuration_type.zig").AccountTakeoverRiskConfigurationType;
const CompromisedCredentialsRiskConfigurationType = @import("compromised_credentials_risk_configuration_type.zig").CompromisedCredentialsRiskConfigurationType;
const RiskExceptionConfigurationType = @import("risk_exception_configuration_type.zig").RiskExceptionConfigurationType;
const RiskConfigurationType = @import("risk_configuration_type.zig").RiskConfigurationType;

pub const SetRiskConfigurationInput = struct {
    /// The settings for automated responses and notification templates for adaptive
    /// authentication with threat protection.
    account_takeover_risk_configuration: ?AccountTakeoverRiskConfigurationType = null,

    /// The ID of the app client where you want to set a risk configuration. If
    /// `ClientId` is null, then the risk configuration is mapped to
    /// `UserPoolId`. When the client ID is null, the same risk configuration is
    /// applied to all the clients in the userPool.
    ///
    /// When you include a `ClientId` parameter, Amazon Cognito maps the
    /// configuration to
    /// the app client. When you include both `ClientId` and `UserPoolId`,
    /// Amazon Cognito maps the configuration to the app client only.
    client_id: ?[]const u8 = null,

    /// The configuration of automated reactions to detected compromised
    /// credentials. Includes
    /// settings for blocking future sign-in requests and for the types of
    /// password-submission
    /// events you want to monitor.
    compromised_credentials_risk_configuration: ?CompromisedCredentialsRiskConfigurationType = null,

    /// A set of IP-address overrides to threat protection. You can set up
    /// IP-address
    /// always-block and always-allow lists.
    risk_exception_configuration: ?RiskExceptionConfigurationType = null,

    /// The ID of the user pool where you want to set a risk configuration. If you
    /// include
    /// `UserPoolId` in your request, don't include `ClientId`.
    /// When the client ID is null, the same risk configuration is applied to all
    /// the clients in
    /// the userPool. When you include both `ClientId` and `UserPoolId`,
    /// Amazon Cognito maps the configuration to the app client only.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .account_takeover_risk_configuration = "AccountTakeoverRiskConfiguration",
        .client_id = "ClientId",
        .compromised_credentials_risk_configuration = "CompromisedCredentialsRiskConfiguration",
        .risk_exception_configuration = "RiskExceptionConfiguration",
        .user_pool_id = "UserPoolId",
    };
};

pub const SetRiskConfigurationOutput = struct {
    /// The API response that contains the risk configuration that you set and the
    /// timestamp
    /// of the most recent change.
    risk_configuration: ?RiskConfigurationType = null,

    pub const json_field_names = .{
        .risk_configuration = "RiskConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetRiskConfigurationInput, options: CallOptions) !SetRiskConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetRiskConfigurationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.SetRiskConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetRiskConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(SetRiskConfigurationOutput, body, allocator);
}
