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

pub const CreateRouterOutputInput = struct {
    /// The Availability Zone where you want to create the router output. This must
    /// be a valid Availability Zone for the region specified by `regionName`, or
    /// the current region if no `regionName` is provided.
    availability_zone: ?[]const u8 = null,

    /// A unique identifier for the request to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// The configuration settings for the router output.
    configuration: RouterOutputConfiguration,

    /// The fabric configuration settings for the router output.
    fabric_configuration: ?FabricConfiguration = null,

    /// The maintenance configuration settings for the router output, including
    /// preferred maintenance windows and schedules.
    maintenance_configuration: ?MaintenanceConfiguration = null,

    /// The maximum bitrate for the router output.
    maximum_bitrate: i64,

    /// The name of the router output.
    name: []const u8,

    /// The Amazon Web Services Region for the router output. Defaults to the
    /// current region if not specified.
    region_name: ?[]const u8 = null,

    /// Specifies whether the router output can take inputs that are in different
    /// Regions. REGIONAL (default) - can only take inputs from same Region. GLOBAL
    /// - can take inputs from any Region.
    routing_scope: RoutingScope,

    /// Key-value pairs that can be used to tag this router output.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The tier level for the router output.
    tier: RouterOutputTier,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .client_token = "ClientToken",
        .configuration = "Configuration",
        .fabric_configuration = "FabricConfiguration",
        .maintenance_configuration = "MaintenanceConfiguration",
        .maximum_bitrate = "MaximumBitrate",
        .name = "Name",
        .region_name = "RegionName",
        .routing_scope = "RoutingScope",
        .tags = "Tags",
        .tier = "Tier",
    };
};

pub const CreateRouterOutputOutput = struct {
    /// The newly-created router output.
    router_output: ?RouterOutput = null,

    pub const json_field_names = .{
        .router_output = "RouterOutput",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRouterOutputInput, options: CallOptions) !CreateRouterOutputOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRouterOutputInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/routerOutput";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.availability_zone) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AvailabilityZone\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Configuration\":");
    try aws.json.writeValue(@TypeOf(input.configuration), input.configuration, allocator, &body_buf);
    has_prev = true;
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MaximumBitrate\":");
    try aws.json.writeValue(@TypeOf(input.maximum_bitrate), input.maximum_bitrate, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.region_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RegionName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RoutingScope\":");
    try aws.json.writeValue(@TypeOf(input.routing_scope), input.routing_scope, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Tier\":");
    try aws.json.writeValue(@TypeOf(input.tier), input.tier, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRouterOutputOutput {
    const result: CreateRouterOutputOutput = try aws.json.parseJsonObject(
        CreateRouterOutputOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
