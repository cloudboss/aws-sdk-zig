const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceConfigDnsResolution = @import("resource_config_dns_resolution.zig").ResourceConfigDnsResolution;
const PrivateConnectionStatus = @import("private_connection_status.zig").PrivateConnectionStatus;
const PrivateConnectionType = @import("private_connection_type.zig").PrivateConnectionType;

pub const DescribePrivateConnectionInput = struct {
    /// The name of the Private Connection.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};

pub const DescribePrivateConnectionOutput = struct {
    /// The expiry time of the certificate associated with the Private Connection.
    /// Only present when a certificate is associated.
    certificate_expiry_time: ?i64 = null,

    /// DNS resolution mode for the Private Connection's resource gateway.
    dns_resolution: ?ResourceConfigDnsResolution = null,

    /// Message describing the reason for a failed Private Connection, if
    /// applicable.
    failure_message: ?[]const u8 = null,

    /// IP address or DNS name of the target resource. Only present for
    /// service-managed Private Connections.
    host_address: ?[]const u8 = null,

    /// The name of the Private Connection.
    name: []const u8,

    /// The Resource Configuration ARN. Only present for self-managed Private
    /// Connections.
    resource_configuration_id: ?[]const u8 = null,

    /// The service-managed Resource Gateway ARN. Only present for service-managed
    /// Private Connections.
    resource_gateway_id: ?[]const u8 = null,

    /// The status of the Private Connection.
    status: PrivateConnectionStatus,

    /// Tags associated with the Private Connection.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the Private Connection.
    type: PrivateConnectionType,

    /// VPC identifier of the service-managed Resource Gateway. Only present for
    /// service-managed Private Connections.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_expiry_time = "certificateExpiryTime",
        .dns_resolution = "dnsResolution",
        .failure_message = "failureMessage",
        .host_address = "hostAddress",
        .name = "name",
        .resource_configuration_id = "resourceConfigurationId",
        .resource_gateway_id = "resourceGatewayId",
        .status = "status",
        .tags = "tags",
        .type = "type",
        .vpc_id = "vpcId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePrivateConnectionInput, options: CallOptions) !DescribePrivateConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aidevops", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePrivateConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aidevops", "DevOps Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/private-connections/");
    try path_buf.appendSlice(allocator, input.name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePrivateConnectionOutput {
    const result: DescribePrivateConnectionOutput = try aws.json.parseJsonObject(
        DescribePrivateConnectionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
