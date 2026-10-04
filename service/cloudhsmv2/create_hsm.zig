const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Hsm = @import("hsm.zig").Hsm;

pub const CreateHsmInput = struct {
    /// The Availability Zone where you are creating the HSM. To find the cluster's
    /// Availability Zones, use DescribeClusters.
    availability_zone: []const u8,

    /// The identifier (ID) of the HSM's cluster. To find the cluster ID, use
    /// DescribeClusters.
    cluster_id: []const u8,

    /// The HSM's IP address. If you specify an IP address, use an available address
    /// from the
    /// subnet that maps to the Availability Zone where you are creating the HSM. If
    /// you don't specify
    /// an IP address, one is chosen for you from that subnet.
    ip_address: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .cluster_id = "ClusterId",
        .ip_address = "IpAddress",
    };
};

pub const CreateHsmOutput = struct {
    /// Information about the HSM that was created.
    hsm: ?Hsm = null,

    pub const json_field_names = .{
        .hsm = "Hsm",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHsmInput, options: CallOptions) !CreateHsmOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudhsm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHsmInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudhsmv2", "CloudHSM V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "BaldrApiService.CreateHsm");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHsmOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateHsmOutput, body, allocator);
}
