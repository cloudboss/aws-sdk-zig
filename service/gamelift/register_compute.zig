const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Compute = @import("compute.zig").Compute;

pub const RegisterComputeInput = struct {
    /// The path to a TLS certificate on your compute resource. Amazon GameLift
    /// Servers doesn't validate the
    /// path and certificate.
    certificate_path: ?[]const u8 = null,

    /// A descriptive label for the compute resource.
    compute_name: []const u8,

    /// The DNS name of the compute resource. Amazon GameLift Servers requires
    /// either a DNS name or IP
    /// address.
    dns_name: ?[]const u8 = null,

    /// A unique identifier for the fleet to register the compute to. You can use
    /// either the fleet ID or ARN value.
    fleet_id: []const u8,

    /// The IP address of the compute resource. Amazon GameLift Servers requires
    /// either a DNS name or IP
    /// address. When registering an Anywhere fleet, an IP address is required.
    ip_address: ?[]const u8 = null,

    /// The name of a custom location to associate with the compute resource being
    /// registered.
    /// This parameter is required when registering a compute for an Anywhere fleet.
    location: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_path = "CertificatePath",
        .compute_name = "ComputeName",
        .dns_name = "DnsName",
        .fleet_id = "FleetId",
        .ip_address = "IpAddress",
        .location = "Location",
    };
};

pub const RegisterComputeOutput = struct {
    /// The details of the compute resource you registered.
    compute: ?Compute = null,

    pub const json_field_names = .{
        .compute = "Compute",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterComputeInput, options: CallOptions) !RegisterComputeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gamelift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterComputeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.RegisterCompute");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterComputeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RegisterComputeOutput, body, allocator);
}
