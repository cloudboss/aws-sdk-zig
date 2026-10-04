const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkforceIpAddressType = @import("workforce_ip_address_type.zig").WorkforceIpAddressType;
const OidcConfig = @import("oidc_config.zig").OidcConfig;
const SourceIpConfig = @import("source_ip_config.zig").SourceIpConfig;
const WorkforceVpcConfigRequest = @import("workforce_vpc_config_request.zig").WorkforceVpcConfigRequest;
const Workforce = @import("workforce.zig").Workforce;

pub const UpdateWorkforceInput = struct {
    /// Use this parameter to specify whether you want `IPv4` only or `dualstack`
    /// (`IPv4` and `IPv6`) to support your labeling workforce.
    ip_address_type: ?WorkforceIpAddressType = null,

    /// Use this parameter to update your OIDC Identity Provider (IdP) configuration
    /// for a workforce made using your own IdP.
    oidc_config: ?OidcConfig = null,

    /// A list of one to ten worker IP address ranges
    /// ([CIDRs](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html))
    /// that can be used to access tasks assigned to this workforce.
    ///
    /// Maximum: Ten CIDR values
    source_ip_config: ?SourceIpConfig = null,

    /// The name of the private workforce that you want to update. You can find your
    /// workforce name by using the
    /// [ListWorkforces](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ListWorkforces.html) operation.
    workforce_name: []const u8,

    /// Use this parameter to update your VPC configuration for a workforce.
    workforce_vpc_config: ?WorkforceVpcConfigRequest = null,

    pub const json_field_names = .{
        .ip_address_type = "IpAddressType",
        .oidc_config = "OidcConfig",
        .source_ip_config = "SourceIpConfig",
        .workforce_name = "WorkforceName",
        .workforce_vpc_config = "WorkforceVpcConfig",
    };
};

pub const UpdateWorkforceOutput = struct {
    /// A single private workforce. You can create one private work force in each
    /// Amazon Web Services Region. By default, any workforce-related API operation
    /// used in a specific region will apply to the workforce created in that
    /// region. To learn how to create a private workforce, see [Create a Private
    /// Workforce](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-workforce-create-private.html).
    workforce: ?Workforce = null,

    pub const json_field_names = .{
        .workforce = "Workforce",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkforceInput, options: CallOptions) !UpdateWorkforceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWorkforceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateWorkforce");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWorkforceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateWorkforceOutput, body, allocator);
}
