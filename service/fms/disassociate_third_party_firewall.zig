const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ThirdPartyFirewall = @import("third_party_firewall.zig").ThirdPartyFirewall;
const ThirdPartyFirewallAssociationStatus = @import("third_party_firewall_association_status.zig").ThirdPartyFirewallAssociationStatus;

pub const DisassociateThirdPartyFirewallInput = struct {
    /// The name of the third-party firewall vendor.
    third_party_firewall: ThirdPartyFirewall,

    pub const json_field_names = .{
        .third_party_firewall = "ThirdPartyFirewall",
    };
};

pub const DisassociateThirdPartyFirewallOutput = struct {
    /// The current status for the disassociation of a Firewall Manager
    /// administrators account with a third-party firewall.
    third_party_firewall_status: ?ThirdPartyFirewallAssociationStatus = null,

    pub const json_field_names = .{
        .third_party_firewall_status = "ThirdPartyFirewallStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateThirdPartyFirewallInput, options: CallOptions) !DisassociateThirdPartyFirewallOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateThirdPartyFirewallInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fms", "FMS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSFMS_20180101.DisassociateThirdPartyFirewall");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateThirdPartyFirewallOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DisassociateThirdPartyFirewallOutput, body, allocator);
}
