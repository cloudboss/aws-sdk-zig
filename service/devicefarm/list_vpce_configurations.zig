const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VPCEConfiguration = @import("vpce_configuration.zig").VPCEConfiguration;

pub const ListVPCEConfigurationsInput = struct {
    /// An integer that specifies the maximum number of items you want to return in
    /// the API response.
    max_results: ?i32 = null,

    /// An identifier that was returned from the previous call to this operation,
    /// which can be
    /// used to return the next set of items in the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListVPCEConfigurationsOutput = struct {
    /// An identifier that was returned from the previous call to this operation,
    /// which can be
    /// used to return the next set of items in the list.
    next_token: ?[]const u8 = null,

    /// An array of `VPCEConfiguration` objects that contain information about your
    /// VPC endpoint
    /// configuration.
    vpce_configurations: ?[]const VPCEConfiguration = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .vpce_configurations = "vpceConfigurations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListVPCEConfigurationsInput, options: CallOptions) !ListVPCEConfigurationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devicefarm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListVPCEConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devicefarm", "Device Farm", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.ListVPCEConfigurations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListVPCEConfigurationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListVPCEConfigurationsOutput, body, allocator);
}
