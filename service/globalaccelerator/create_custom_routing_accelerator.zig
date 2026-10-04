const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const Tag = @import("tag.zig").Tag;
const CustomRoutingAccelerator = @import("custom_routing_accelerator.zig").CustomRoutingAccelerator;

pub const CreateCustomRoutingAcceleratorInput = struct {
    /// Indicates whether an accelerator is enabled. The value is true or false. The
    /// default value is true.
    ///
    /// If the value is set to true, an accelerator cannot be deleted. If set to
    /// false, the accelerator can be deleted.
    enabled: ?bool = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency—that
    /// is, the uniqueness—of the request.
    idempotency_token: []const u8,

    /// Optionally, if you've added your own IP address pool to Global Accelerator
    /// (BYOIP), you can choose an IPv4 address
    /// from your own pool to use for the accelerator's static IPv4 address when you
    /// create an accelerator.
    ///
    /// After you bring an address range to Amazon Web Services, it appears in your
    /// account as an address pool.
    /// When you create an accelerator, you can assign one IPv4 address from your
    /// range to it. Global Accelerator assigns
    /// you a second static IPv4 address from an Amazon IP address range. If you
    /// bring two IPv4 address ranges
    /// to Amazon Web Services, you can assign one IPv4 address from each range to
    /// your accelerator. This restriction is
    /// because Global Accelerator assigns each address range to a different network
    /// zone, for high availability.
    ///
    /// You can specify one or two addresses, separated by a space. Do not include
    /// the /32 suffix.
    ///
    /// Note that you can't update IP addresses for an existing accelerator. To
    /// change them, you must create a new
    /// accelerator with the new addresses.
    ///
    /// For more information, see [Bring
    /// your own IP addresses
    /// (BYOIP)](https://docs.aws.amazon.com/global-accelerator/latest/dg/using-byoip.html) in the *Global Accelerator Developer Guide*.
    ip_addresses: ?[]const []const u8 = null,

    /// The IP address type that an accelerator supports. For a custom routing
    /// accelerator, the value must be IPV4.
    ip_address_type: ?IpAddressType = null,

    /// The name of a custom routing accelerator. The name can have a maximum of 64
    /// characters, must contain
    /// only alphanumeric characters or hyphens (-), and must not begin or end with
    /// a hyphen.
    name: []const u8,

    /// Create tags for an accelerator.
    ///
    /// For more information, see [Tagging
    /// in Global
    /// Accelerator](https://docs.aws.amazon.com/global-accelerator/latest/dg/tagging-in-global-accelerator.html) in the *Global Accelerator Developer Guide*.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .idempotency_token = "IdempotencyToken",
        .ip_addresses = "IpAddresses",
        .ip_address_type = "IpAddressType",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateCustomRoutingAcceleratorOutput = struct {
    /// The accelerator that is created.
    accelerator: ?CustomRoutingAccelerator = null,

    pub const json_field_names = .{
        .accelerator = "Accelerator",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCustomRoutingAcceleratorInput, options: CallOptions) !CreateCustomRoutingAcceleratorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "globalaccelerator", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCustomRoutingAcceleratorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("globalaccelerator", "Global Accelerator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GlobalAccelerator_V20180706.CreateCustomRoutingAccelerator");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCustomRoutingAcceleratorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCustomRoutingAcceleratorOutput, body, allocator);
}
