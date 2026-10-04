const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Vlan = @import("vlan.zig").Vlan;

pub const DisassociateEipFromVlanInput = struct {
    /// A unique ID for the Elastic IP address association.
    association_id: []const u8,

    /// This parameter is not used in Amazon EVS currently. If you supply input for
    /// this parameter, it will have no effect.
    ///
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the environment creation request. If you do not specify a
    /// client token, a randomly generated token is used for the request to ensure
    /// idempotency.
    client_token: ?[]const u8 = null,

    /// A unique ID for the environment containing the VLAN that the Elastic IP
    /// address disassociates from.
    environment_id: []const u8,

    /// The name of the VLAN. `hcx` is the only accepted VLAN name at this time.
    vlan_name: []const u8,

    pub const json_field_names = .{
        .association_id = "associationId",
        .client_token = "clientToken",
        .environment_id = "environmentId",
        .vlan_name = "vlanName",
    };
};

pub const DisassociateEipFromVlanOutput = struct {
    vlan: ?Vlan = null,

    pub const json_field_names = .{
        .vlan = "vlan",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateEipFromVlanInput, options: CallOptions) !DisassociateEipFromVlanOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "evs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateEipFromVlanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("evs", "evs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonElasticVMwareService.DisassociateEipFromVlan");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateEipFromVlanOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DisassociateEipFromVlanOutput, body, allocator);
}
