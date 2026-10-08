const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TraceContent = @import("trace_content.zig").TraceContent;

pub const UpdateNetworkAnalyzerConfigurationInput = struct {
    configuration_name: []const u8,

    description: ?[]const u8 = null,

    /// Multicast group resources to add to the network analyzer configuration.
    /// Provide the
    /// `MulticastGroupId` of the resource to add in the input array.
    multicast_groups_to_add: ?[]const []const u8 = null,

    /// Multicast group resources to remove from the network analyzer configuration.
    /// Provide
    /// the `MulticastGroupId` of the resources to remove in the input array.
    multicast_groups_to_remove: ?[]const []const u8 = null,

    trace_content: ?TraceContent = null,

    /// Wireless device resources to add to the network analyzer configuration.
    /// Provide the
    /// `WirelessDeviceId` of the resource to add in the input array.
    wireless_devices_to_add: ?[]const []const u8 = null,

    /// Wireless device resources to remove from the network analyzer configuration.
    /// Provide
    /// the `WirelessDeviceId` of the resources to remove in the input array.
    wireless_devices_to_remove: ?[]const []const u8 = null,

    /// Wireless gateway resources to add to the network analyzer configuration.
    /// Provide the
    /// `WirelessGatewayId` of the resource to add in the input array.
    wireless_gateways_to_add: ?[]const []const u8 = null,

    /// Wireless gateway resources to remove from the network analyzer
    /// configuration. Provide
    /// the `WirelessGatewayId` of the resources to remove in the input array.
    wireless_gateways_to_remove: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .configuration_name = "ConfigurationName",
        .description = "Description",
        .multicast_groups_to_add = "MulticastGroupsToAdd",
        .multicast_groups_to_remove = "MulticastGroupsToRemove",
        .trace_content = "TraceContent",
        .wireless_devices_to_add = "WirelessDevicesToAdd",
        .wireless_devices_to_remove = "WirelessDevicesToRemove",
        .wireless_gateways_to_add = "WirelessGatewaysToAdd",
        .wireless_gateways_to_remove = "WirelessGatewaysToRemove",
    };
};

pub const UpdateNetworkAnalyzerConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateNetworkAnalyzerConfigurationInput, options: CallOptions) !UpdateNetworkAnalyzerConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateNetworkAnalyzerConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/network-analyzer-configurations/");
    try path_buf.appendSlice(allocator, input.configuration_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.multicast_groups_to_add) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MulticastGroupsToAdd\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.multicast_groups_to_remove) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MulticastGroupsToRemove\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.trace_content) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TraceContent\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.wireless_devices_to_add) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WirelessDevicesToAdd\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.wireless_devices_to_remove) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WirelessDevicesToRemove\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.wireless_gateways_to_add) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WirelessGatewaysToAdd\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.wireless_gateways_to_remove) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WirelessGatewaysToRemove\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateNetworkAnalyzerConfigurationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateNetworkAnalyzerConfigurationOutput = .{};

    return result;
}
