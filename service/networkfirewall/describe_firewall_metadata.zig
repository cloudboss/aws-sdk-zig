const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FirewallStatusValue = @import("firewall_status_value.zig").FirewallStatusValue;
const AvailabilityZoneMetadata = @import("availability_zone_metadata.zig").AvailabilityZoneMetadata;

pub const DescribeFirewallMetadataInput = struct {
    /// The Amazon Resource Name (ARN) of the firewall.
    firewall_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .firewall_arn = "FirewallArn",
    };
};

pub const DescribeFirewallMetadataOutput = struct {
    /// A description of the firewall.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the firewall.
    firewall_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the firewall policy.
    firewall_policy_arn: ?[]const u8 = null,

    /// The readiness of the configured firewall to handle network traffic across
    /// all of the
    /// Availability Zones where you have it configured. This setting is `READY`
    /// only when
    /// the `ConfigurationSyncStateSummary` value is `IN_SYNC` and the
    /// `Attachment`
    /// `Status` values for all of the configured subnets are `READY`.
    status: ?FirewallStatusValue = null,

    /// The Availability Zones that the firewall currently supports. This includes
    /// all Availability Zones for which
    /// the firewall has a subnet defined.
    supported_availability_zones: ?[]const aws.map.MapEntry(AvailabilityZoneMetadata) = null,

    /// The unique identifier of the transit gateway attachment associated with this
    /// firewall. This field is only present for transit gateway-attached firewalls.
    transit_gateway_attachment_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .firewall_arn = "FirewallArn",
        .firewall_policy_arn = "FirewallPolicyArn",
        .status = "Status",
        .supported_availability_zones = "SupportedAvailabilityZones",
        .transit_gateway_attachment_id = "TransitGatewayAttachmentId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFirewallMetadataInput, options: CallOptions) !DescribeFirewallMetadataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "network-firewall", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFirewallMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("network-firewall", "Network Firewall", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.DescribeFirewallMetadata");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFirewallMetadataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeFirewallMetadataOutput, body, allocator);
}
