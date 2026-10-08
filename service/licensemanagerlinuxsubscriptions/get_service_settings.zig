const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LinuxSubscriptionsDiscovery = @import("linux_subscriptions_discovery.zig").LinuxSubscriptionsDiscovery;
const LinuxSubscriptionsDiscoverySettings = @import("linux_subscriptions_discovery_settings.zig").LinuxSubscriptionsDiscoverySettings;
const Status = @import("status.zig").Status;

pub const GetServiceSettingsInput = struct {};

pub const GetServiceSettingsOutput = struct {
    /// The Region in which License Manager displays the aggregated data for Linux
    /// subscriptions.
    home_regions: ?[]const []const u8 = null,

    /// Lists if discovery has been enabled for Linux subscriptions.
    linux_subscriptions_discovery: ?LinuxSubscriptionsDiscovery = null,

    /// Lists the settings defined for Linux subscriptions discovery. The settings
    /// include if
    /// Organizations integration has been enabled, and which Regions data will be
    /// aggregated from.
    linux_subscriptions_discovery_settings: ?LinuxSubscriptionsDiscoverySettings = null,

    /// Indicates the status of Linux subscriptions settings being applied.
    status: ?Status = null,

    /// A message which details the Linux subscriptions service settings current
    /// status.
    status_message: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .home_regions = "HomeRegions",
        .linux_subscriptions_discovery = "LinuxSubscriptionsDiscovery",
        .linux_subscriptions_discovery_settings = "LinuxSubscriptionsDiscoverySettings",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetServiceSettingsInput, options: CallOptions) !GetServiceSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "license-manager-linux-subscriptions", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetServiceSettingsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("license-manager-linux-subscriptions", "License Manager Linux Subscriptions", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/subscription/GetServiceSettings";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetServiceSettingsOutput {
    const result: GetServiceSettingsOutput = try aws.json.parseJsonObject(
        GetServiceSettingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
