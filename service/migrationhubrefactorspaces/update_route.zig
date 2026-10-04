const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RouteActivationState = @import("route_activation_state.zig").RouteActivationState;
const RouteState = @import("route_state.zig").RouteState;

pub const UpdateRouteInput = struct {
    /// If set to `ACTIVE`, traffic is forwarded to this route’s service after the
    /// route is updated.
    activation_state: RouteActivationState,

    /// The ID of the application within which the route is being updated.
    application_identifier: []const u8,

    /// The ID of the environment in which the route is being updated.
    environment_identifier: []const u8,

    /// The unique identifier of the route to update.
    route_identifier: []const u8,

    pub const json_field_names = .{
        .activation_state = "ActivationState",
        .application_identifier = "ApplicationIdentifier",
        .environment_identifier = "EnvironmentIdentifier",
        .route_identifier = "RouteIdentifier",
    };
};

pub const UpdateRouteOutput = struct {
    /// The ID of the application in which the route is being updated.
    application_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the route. The format for this ARN is
    /// `arn:aws:refactor-spaces:*region*:*account-id*:*resource-type/resource-id*
    /// `. For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference*.
    arn: ?[]const u8 = null,

    /// A timestamp that indicates when the route was last updated.
    last_updated_time: ?i64 = null,

    /// The unique identifier of the route.
    route_id: ?[]const u8 = null,

    /// The ID of service in which the route was created. Traffic that matches this
    /// route is
    /// forwarded to this service.
    service_id: ?[]const u8 = null,

    /// The current state of the route.
    state: ?RouteState = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .arn = "Arn",
        .last_updated_time = "LastUpdatedTime",
        .route_id = "RouteId",
        .service_id = "ServiceId",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRouteInput, options: CallOptions) !UpdateRouteOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "refactor-spaces", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRouteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("refactor-spaces", "Migration Hub Refactor Spaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.environment_identifier);
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_identifier);
    try path_buf.appendSlice(allocator, "/routes/");
    try path_buf.appendSlice(allocator, input.route_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ActivationState\":");
    try aws.json.writeValue(@TypeOf(input.activation_state), input.activation_state, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRouteOutput {
    const result: UpdateRouteOutput = try aws.json.parseJsonObject(
        UpdateRouteOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
