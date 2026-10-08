const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceConfigDnsResolution = @import("resource_config_dns_resolution.zig").ResourceConfigDnsResolution;
const PrivateConnectionStatus = @import("private_connection_status.zig").PrivateConnectionStatus;
const PrivateConnectionType = @import("private_connection_type.zig").PrivateConnectionType;

pub const UpdatePrivateConnectionCertificateInput = struct {
    /// The PEM-encoded certificate chain for the private connection.
    certificate: []const u8,

    /// The name of the private connection to update.
    private_connection_name: []const u8,

    pub const json_field_names = .{
        .certificate = "certificate",
        .private_connection_name = "privateConnectionName",
    };
};

pub const UpdatePrivateConnectionCertificateOutput = struct {
    /// The date and time the connection's certificate expires, in UTC format.
    certificate_expiry_time: ?i64 = null,

    /// The DNS resolution mode for the resource gateway.
    dns_resolution: ?ResourceConfigDnsResolution = null,

    /// A message describing why the private connection entered a failed state, if
    /// applicable.
    failure_message: ?[]const u8 = null,

    /// The IP address or DNS name of the target resource.
    host_address: ?[]const u8 = null,

    /// The name of the private connection.
    name: []const u8,

    /// The identifier or ARN of the VPC Lattice resource configuration.
    resource_configuration_id: ?[]const u8 = null,

    /// The identifier or ARN of the VPC Lattice resource gateway.
    resource_gateway_id: ?[]const u8 = null,

    /// The current status of the private connection.
    status: PrivateConnectionStatus,

    /// The tags attached to the private connection.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the private connection, indicating whether it is service-managed
    /// or self-managed.
    type: PrivateConnectionType,

    /// The identifier of the VPC the resource gateway is created in.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePrivateConnectionCertificateInput, options: CallOptions) !UpdatePrivateConnectionCertificateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityagent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePrivateConnectionCertificateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdatePrivateConnectionCertificate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"certificate\":");
    try aws.json.writeValue(@TypeOf(input.certificate), input.certificate, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"privateConnectionName\":");
    try aws.json.writeValue(@TypeOf(input.private_connection_name), input.private_connection_name, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePrivateConnectionCertificateOutput {
    const result: UpdatePrivateConnectionCertificateOutput = try aws.json.parseJsonObject(
        UpdatePrivateConnectionCertificateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
