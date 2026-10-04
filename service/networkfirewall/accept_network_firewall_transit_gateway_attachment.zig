const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TransitGatewayAttachmentStatus = @import("transit_gateway_attachment_status.zig").TransitGatewayAttachmentStatus;

pub const AcceptNetworkFirewallTransitGatewayAttachmentInput = struct {
    /// Required. The unique identifier of the transit gateway attachment to accept.
    /// This ID is returned in the response when creating a transit gateway-attached
    /// firewall.
    transit_gateway_attachment_id: []const u8,

    pub const json_field_names = .{
        .transit_gateway_attachment_id = "TransitGatewayAttachmentId",
    };
};

pub const AcceptNetworkFirewallTransitGatewayAttachmentOutput = struct {
    /// The unique identifier of the transit gateway attachment that was accepted.
    transit_gateway_attachment_id: []const u8,

    /// The current status of the transit gateway attachment. Valid values are:
    ///
    /// * `CREATING` - The attachment is being created
    ///
    /// * `DELETING` - The attachment is being deleted
    ///
    /// * `DELETED` - The attachment has been deleted
    ///
    /// * `FAILED` - The attachment creation has failed and cannot be recovered
    ///
    /// * `ERROR` - The attachment is in an error state that might be recoverable
    ///
    /// * `READY` - The attachment is active and processing traffic
    ///
    /// * `PENDING_ACCEPTANCE` - The attachment is waiting to be accepted
    ///
    /// * `REJECTING` - The attachment is in the process of being rejected
    ///
    /// * `REJECTED` - The attachment has been rejected
    transit_gateway_attachment_status: TransitGatewayAttachmentStatus,

    pub const json_field_names = .{
        .transit_gateway_attachment_id = "TransitGatewayAttachmentId",
        .transit_gateway_attachment_status = "TransitGatewayAttachmentStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AcceptNetworkFirewallTransitGatewayAttachmentInput, options: CallOptions) !AcceptNetworkFirewallTransitGatewayAttachmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AcceptNetworkFirewallTransitGatewayAttachmentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.AcceptNetworkFirewallTransitGatewayAttachment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AcceptNetworkFirewallTransitGatewayAttachmentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(AcceptNetworkFirewallTransitGatewayAttachmentOutput, body, allocator);
}
