const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Region = @import("region.zig").Region;

pub const GetRegionsInput = struct {
    /// A Boolean value indicating whether to also include Availability Zones in
    /// your get regions
    /// request. Availability Zones are indicated with a letter: `us-east-2a`.
    include_availability_zones: ?bool = null,

    /// A Boolean value indicating whether to also include Availability Zones for
    /// databases in
    /// your get regions request. Availability Zones are indicated with a letter
    /// (`us-east-2a`).
    include_relational_database_availability_zones: ?bool = null,

    pub const json_field_names = .{
        .include_availability_zones = "includeAvailabilityZones",
        .include_relational_database_availability_zones = "includeRelationalDatabaseAvailabilityZones",
    };
};

pub const GetRegionsOutput = struct {
    /// An array of key-value pairs containing information about your get regions
    /// request.
    regions: ?[]const Region = null,

    pub const json_field_names = .{
        .regions = "regions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRegionsInput, options: CallOptions) !GetRegionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRegionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.GetRegions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRegionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRegionsOutput, body, allocator);
}
