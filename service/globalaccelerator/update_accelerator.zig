const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const Accelerator = @import("accelerator.zig").Accelerator;

pub const UpdateAcceleratorInput = struct {
    /// The Amazon Resource Name (ARN) of the accelerator to update.
    accelerator_arn: []const u8,

    /// Indicates whether an accelerator is enabled. The value is true or false. The
    /// default value is true.
    ///
    /// If the value is set to true, the accelerator cannot be deleted. If set to
    /// false, the accelerator can be deleted.
    enabled: ?bool = null,

    /// The IP addresses for an accelerator.
    ip_addresses: ?[]const []const u8 = null,

    /// The IP address type that an accelerator supports. For a standard
    /// accelerator, the value can be IPV4 or DUAL_STACK.
    ip_address_type: ?IpAddressType = null,

    /// The name of the accelerator. The name can have a maximum of 64 characters,
    /// must contain only alphanumeric characters,
    /// periods (.), or hyphens (-), and must not begin or end with a hyphen or
    /// period.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .accelerator_arn = "AcceleratorArn",
        .enabled = "Enabled",
        .ip_addresses = "IpAddresses",
        .ip_address_type = "IpAddressType",
        .name = "Name",
    };
};

pub const UpdateAcceleratorOutput = struct {
    /// Information about the updated accelerator.
    accelerator: ?Accelerator = null,

    pub const json_field_names = .{
        .accelerator = "Accelerator",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAcceleratorInput, options: CallOptions) !UpdateAcceleratorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAcceleratorInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GlobalAccelerator_V20180706.UpdateAccelerator");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAcceleratorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateAcceleratorOutput, body, allocator);
}
