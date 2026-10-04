const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RouterOutputConfiguration = @import("router_output_configuration.zig").RouterOutputConfiguration;
const FabricConfiguration = @import("fabric_configuration.zig").FabricConfiguration;
const MaintenanceConfiguration = @import("maintenance_configuration.zig").MaintenanceConfiguration;
const RoutingScope = @import("routing_scope.zig").RoutingScope;
const RouterOutputTier = @import("router_output_tier.zig").RouterOutputTier;
const RouterOutput = @import("router_output.zig").RouterOutput;

pub const UpdateRouterOutputInput = struct {
    /// The Amazon Resource Name (ARN) of the router output that you want to update.
    arn: []const u8,

    /// The updated configuration settings for the router output. Changing the type
    /// of the configuration is not supported.
    configuration: ?RouterOutputConfiguration = null,

    /// The updated fabric configuration settings for the router output. You cannot
    /// update the fabric configuration while the output has an active route. You
    /// must unroute the output before updating the fabric configuration.
    fabric_configuration: ?FabricConfiguration = null,

    /// The updated maintenance configuration settings for the router output,
    /// including any changes to preferred maintenance windows and schedules.
    maintenance_configuration: ?MaintenanceConfiguration = null,

    /// The updated maximum bitrate for the router output.
    maximum_bitrate: ?i64 = null,

    /// The updated name for the router output.
    name: ?[]const u8 = null,

    /// Specifies whether the router output can take inputs that are in different
    /// Regions. REGIONAL (default) - can only take inputs from same Region. GLOBAL
    /// - can take inputs from any Region.
    routing_scope: ?RoutingScope = null,

    /// The updated tier level for the router output.
    tier: ?RouterOutputTier = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .configuration = "Configuration",
        .fabric_configuration = "FabricConfiguration",
        .maintenance_configuration = "MaintenanceConfiguration",
        .maximum_bitrate = "MaximumBitrate",
        .name = "Name",
        .routing_scope = "RoutingScope",
        .tier = "Tier",
    };
};

pub const UpdateRouterOutputOutput = struct {
    /// The updated router output.
    router_output: ?RouterOutput = null,

    pub const json_field_names = .{
        .router_output = "RouterOutput",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRouterOutputInput, options: CallOptions) !UpdateRouterOutputOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediaconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRouterOutputInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/routerOutput/");
    try path_buf.appendSlice(allocator, input.arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Configuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.fabric_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FabricConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maintenance_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaintenanceConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maximum_bitrate) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaximumBitrate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.routing_scope) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RoutingScope\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRouterOutputOutput {
    const result: UpdateRouterOutputOutput = try aws.json.parseJsonObject(
        UpdateRouterOutputOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
