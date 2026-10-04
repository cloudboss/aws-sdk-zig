const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TraceContent = @import("trace_content.zig").TraceContent;

pub const GetNetworkAnalyzerConfigurationInput = struct {
    configuration_name: []const u8,

    pub const json_field_names = .{
        .configuration_name = "ConfigurationName",
    };
};

pub const GetNetworkAnalyzerConfigurationOutput = struct {
    /// The Amazon Resource Name of the new resource.
    arn: ?[]const u8 = null,

    description: ?[]const u8 = null,

    /// List of multicast group resources that have been added to the network
    /// analyzer
    /// configuration.
    multicast_groups: ?[]const []const u8 = null,

    name: ?[]const u8 = null,

    trace_content: ?TraceContent = null,

    /// List of wireless device resources that have been added to the network
    /// analyzer
    /// configuration.
    wireless_devices: ?[]const []const u8 = null,

    /// List of wireless gateway resources that have been added to the network
    /// analyzer
    /// configuration.
    wireless_gateways: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .multicast_groups = "MulticastGroups",
        .name = "Name",
        .trace_content = "TraceContent",
        .wireless_devices = "WirelessDevices",
        .wireless_gateways = "WirelessGateways",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetNetworkAnalyzerConfigurationInput, options: CallOptions) !GetNetworkAnalyzerConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotwireless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetNetworkAnalyzerConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/network-analyzer-configurations/");
    try path_buf.appendSlice(allocator, input.configuration_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetNetworkAnalyzerConfigurationOutput {
    var result: GetNetworkAnalyzerConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetNetworkAnalyzerConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
