const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AddressFamily = @import("address_family.zig").AddressFamily;
const BGPPeer = @import("bgp_peer.zig").BGPPeer;
const RouteFilterPrefix = @import("route_filter_prefix.zig").RouteFilterPrefix;
const Tag = @import("tag.zig").Tag;
const VirtualInterfaceState = @import("virtual_interface_state.zig").VirtualInterfaceState;

pub const UpdateVirtualInterfaceAttributesInput = struct {
    /// Indicates whether to enable or disable SiteLink.
    enable_site_link: ?bool = null,

    /// The maximum transmission unit (MTU), in bytes. The supported values are 1500
    /// and 8500. The default value is 1500.
    mtu: ?i32 = null,

    /// The number of inbound IPv4 route prefixes to allocate to the virtual
    /// interface. Not applicable to public virtual interfaces.
    prefix_pool_allocated_count_ipv_4: ?i32 = null,

    /// The number of inbound IPv6 route prefixes to allocate to the virtual
    /// interface. Not applicable to public virtual interfaces.
    prefix_pool_allocated_count_ipv_6: ?i32 = null,

    /// The rate limit (bandwidth allocation) to apply to the virtual interface. Use
    /// this to update the bandwidth allocation on an existing virtual interface.
    rate_limit: ?[]const u8 = null,

    /// The ID of the virtual private interface.
    virtual_interface_id: []const u8,

    /// The name of the virtual private interface.
    virtual_interface_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .enable_site_link = "enableSiteLink",
        .mtu = "mtu",
        .prefix_pool_allocated_count_ipv_4 = "prefixPoolAllocatedCountIpv4",
        .prefix_pool_allocated_count_ipv_6 = "prefixPoolAllocatedCountIpv6",
        .rate_limit = "rateLimit",
        .virtual_interface_id = "virtualInterfaceId",
        .virtual_interface_name = "virtualInterfaceName",
    };
};

pub const UpdateVirtualInterfaceAttributesOutput = @import("virtual_interface.zig").VirtualInterface;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateVirtualInterfaceAttributesInput, options: CallOptions) !UpdateVirtualInterfaceAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateVirtualInterfaceAttributesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "OvertureService.UpdateVirtualInterfaceAttributes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateVirtualInterfaceAttributesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateVirtualInterfaceAttributesOutput, body, allocator);
}
