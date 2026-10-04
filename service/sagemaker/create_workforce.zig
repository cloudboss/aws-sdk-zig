const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CognitoConfig = @import("cognito_config.zig").CognitoConfig;
const WorkforceIpAddressType = @import("workforce_ip_address_type.zig").WorkforceIpAddressType;
const OidcConfig = @import("oidc_config.zig").OidcConfig;
const SourceIpConfig = @import("source_ip_config.zig").SourceIpConfig;
const Tag = @import("tag.zig").Tag;
const WorkforceVpcConfigRequest = @import("workforce_vpc_config_request.zig").WorkforceVpcConfigRequest;

pub const CreateWorkforceInput = struct {
    /// Use this parameter to configure an Amazon Cognito private workforce. A
    /// single Cognito workforce is created using and corresponds to a single [
    /// Amazon Cognito user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools.html).
    ///
    /// Do not use `OidcConfig` if you specify values for `CognitoConfig`.
    cognito_config: ?CognitoConfig = null,

    /// Use this parameter to specify whether you want `IPv4` only or `dualstack`
    /// (`IPv4` and `IPv6`) to support your labeling workforce.
    ip_address_type: ?WorkforceIpAddressType = null,

    /// Use this parameter to configure a private workforce using your own OIDC
    /// Identity Provider.
    ///
    /// Do not use `CognitoConfig` if you specify values for `OidcConfig`.
    oidc_config: ?OidcConfig = null,

    source_ip_config: ?SourceIpConfig = null,

    /// An array of key-value pairs that contain metadata to help you categorize and
    /// organize our workforce. Each tag consists of a key and a value, both of
    /// which you define.
    tags: ?[]const Tag = null,

    /// The name of the private workforce.
    workforce_name: []const u8,

    /// Use this parameter to configure a workforce using VPC.
    workforce_vpc_config: ?WorkforceVpcConfigRequest = null,

    pub const json_field_names = .{
        .cognito_config = "CognitoConfig",
        .ip_address_type = "IpAddressType",
        .oidc_config = "OidcConfig",
        .source_ip_config = "SourceIpConfig",
        .tags = "Tags",
        .workforce_name = "WorkforceName",
        .workforce_vpc_config = "WorkforceVpcConfig",
    };
};

pub const CreateWorkforceOutput = struct {
    /// The Amazon Resource Name (ARN) of the workforce.
    workforce_arn: []const u8,

    pub const json_field_names = .{
        .workforce_arn = "WorkforceArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkforceInput, options: CallOptions) !CreateWorkforceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkforceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateWorkforce");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkforceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateWorkforceOutput, body, allocator);
}
