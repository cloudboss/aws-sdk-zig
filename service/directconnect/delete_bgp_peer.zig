const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VirtualInterface = @import("virtual_interface.zig").VirtualInterface;

pub const DeleteBGPPeerInput = struct {
    /// The autonomous system number (ASN). The valid range is from 1 to 2147483646
    /// for Border Gateway Protocol (BGP) configuration. If you provide a number
    /// greater than the maximum, an error is returned. Use `asnLong` instead.
    ///
    /// * You can use `asnLong` or `asn`, but not both. We recommend using `asnLong`
    ///   as it supports a greater pool of numbers.
    ///
    /// * If you provide a value in the same API call for both `asn`
    /// and `asnLong`, the API will only accept the value for
    /// `asnLong`.
    ///
    /// * If you enter a 4-byte ASN for the `asn` parameter, the API returns an
    ///   error.
    ///
    /// * If you are using a 2-byte ASN, the API response will include the
    /// 2-byte value for both the `asn` and `asnLong` fields.
    asn: ?i32 = null,

    /// The long ASN for the BGP peer to be deleted from a Direct Connect virtual
    /// interface. The valid range is from 1 to 4294967294 for BGP configuration.
    ///
    /// Note the following limitations when using `asnLong`:
    ///
    /// * You can use `asnLong` or `asn`, but not both. We recommend using `asnLong`
    ///   as it supports a greater pool of numbers.
    ///
    /// * `asnLong` accepts any valid ASN value, regardless if it's 2-byte or
    ///   4-byte.
    ///
    /// * When using a 4-byte `asnLong`, the API response returns `0` for the legacy
    ///   `asn` attribute since 4-byte ASN values exceed the maximum supported value
    ///   of 2,147,483,647.
    ///
    /// * If you are using a 2-byte ASN, the API response will include the
    /// 2-byte value for both the `asn` and `asnLong` fields.
    ///
    /// * If you provide a value in the same API call for both `asn`
    /// and `asnLong`, the API will only accept the value for
    /// `asnLong`.
    asn_long: ?i64 = null,

    /// The ID of the BGP peer.
    bgp_peer_id: ?[]const u8 = null,

    /// The IP address assigned to the customer interface.
    customer_address: ?[]const u8 = null,

    /// The ID of the virtual interface.
    virtual_interface_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .asn = "asn",
        .asn_long = "asnLong",
        .bgp_peer_id = "bgpPeerId",
        .customer_address = "customerAddress",
        .virtual_interface_id = "virtualInterfaceId",
    };
};

pub const DeleteBGPPeerOutput = struct {
    /// The virtual interface.
    virtual_interface: ?VirtualInterface = null,

    pub const json_field_names = .{
        .virtual_interface = "virtualInterface",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteBGPPeerInput, options: CallOptions) !DeleteBGPPeerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "directconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteBGPPeerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("directconnect", "Direct Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "OvertureService.DeleteBGPPeer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteBGPPeerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteBGPPeerOutput, body, allocator);
}
