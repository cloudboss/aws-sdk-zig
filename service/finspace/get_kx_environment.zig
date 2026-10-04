const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomDNSServer = @import("custom_dns_server.zig").CustomDNSServer;
const dnsStatus = @import("dns_status.zig").dnsStatus;
const EnvironmentStatus = @import("environment_status.zig").EnvironmentStatus;
const tgwStatus = @import("tgw_status.zig").tgwStatus;
const TransitGatewayConfiguration = @import("transit_gateway_configuration.zig").TransitGatewayConfiguration;

pub const GetKxEnvironmentInput = struct {
    /// A unique identifier for the kdb environment.
    environment_id: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
    };
};

pub const GetKxEnvironmentOutput = struct {
    /// The identifier of the availability zones where subnets for the environment
    /// are created.
    availability_zone_ids: ?[]const []const u8 = null,

    /// The unique identifier of the AWS account that is used to create the kdb
    /// environment.
    aws_account_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the certificate authority of the
    /// kdb environment.
    certificate_authority_arn: ?[]const u8 = null,

    /// The timestamp at which the kdb environment was created in FinSpace.
    creation_timestamp: ?i64 = null,

    /// A list of DNS server name and server IP. This is used to set up Route-53
    /// outbound resolvers.
    custom_dns_configuration: ?[]const CustomDNSServer = null,

    /// A unique identifier for the AWS environment infrastructure account.
    dedicated_service_account_id: ?[]const u8 = null,

    /// A description for the kdb environment.
    description: ?[]const u8 = null,

    /// The status of DNS configuration.
    dns_status: ?dnsStatus = null,

    /// The ARN identifier of the environment.
    environment_arn: ?[]const u8 = null,

    /// A unique identifier for the kdb environment.
    environment_id: ?[]const u8 = null,

    /// Specifies the error message that appears if a flow fails.
    error_message: ?[]const u8 = null,

    /// The KMS key ID to encrypt your data in the FinSpace environment.
    kms_key_id: ?[]const u8 = null,

    /// The name of the kdb environment.
    name: ?[]const u8 = null,

    /// The status of the kdb environment.
    status: ?EnvironmentStatus = null,

    /// The status of the network configuration.
    tgw_status: ?tgwStatus = null,

    transit_gateway_configuration: ?TransitGatewayConfiguration = null,

    /// The timestamp at which the kdb environment was updated.
    update_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .availability_zone_ids = "availabilityZoneIds",
        .aws_account_id = "awsAccountId",
        .certificate_authority_arn = "certificateAuthorityArn",
        .creation_timestamp = "creationTimestamp",
        .custom_dns_configuration = "customDNSConfiguration",
        .dedicated_service_account_id = "dedicatedServiceAccountId",
        .description = "description",
        .dns_status = "dnsStatus",
        .environment_arn = "environmentArn",
        .environment_id = "environmentId",
        .error_message = "errorMessage",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .status = "status",
        .tgw_status = "tgwStatus",
        .transit_gateway_configuration = "transitGatewayConfiguration",
        .update_timestamp = "updateTimestamp",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetKxEnvironmentInput, options: CallOptions) !GetKxEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "finspace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetKxEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/kx/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetKxEnvironmentOutput {
    var result: GetKxEnvironmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetKxEnvironmentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
