const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ErrorResponse = @import("error_response.zig").ErrorResponse;
const HttpMethod = @import("http_method.zig").HttpMethod;
const RouteType = @import("route_type.zig").RouteType;
const RouteState = @import("route_state.zig").RouteState;

pub const GetRouteInput = struct {
    /// The ID of the application.
    application_identifier: []const u8,

    /// The ID of the environment.
    environment_identifier: []const u8,

    /// The ID of the route.
    route_identifier: []const u8,

    pub const json_field_names = .{
        .application_identifier = "ApplicationIdentifier",
        .environment_identifier = "EnvironmentIdentifier",
        .route_identifier = "RouteIdentifier",
    };
};

pub const GetRouteOutput = struct {
    /// If set to `true`, this option appends the source path to the service URL
    /// endpoint.
    append_source_path: ?bool = null,

    /// The ID of the application that the route belongs to.
    application_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the route.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the route creator.
    created_by_account_id: ?[]const u8 = null,

    /// The timestamp of when the route is created.
    created_time: ?i64 = null,

    /// Unique identifier of the environment.
    environment_id: ?[]const u8 = null,

    /// Any error associated with the route resource.
    @"error": ?ErrorResponse = null,

    /// Indicates whether to match all subpaths of the given source path. If this
    /// value is
    /// `false`, requests must match the source path exactly before they are
    /// forwarded to
    /// this route's service.
    include_child_paths: ?bool = null,

    /// A timestamp that indicates when the route was last updated.
    last_updated_time: ?i64 = null,

    /// A list of HTTP methods to match. An empty list matches all values. If a
    /// method is present,
    /// only HTTP requests using that method are forwarded to this route’s service.
    methods: ?[]const HttpMethod = null,

    /// The Amazon Web Services account ID of the route owner.
    owner_account_id: ?[]const u8 = null,

    /// A mapping of Amazon API Gateway path resources to resource IDs.
    path_resource_to_id: ?[]const aws.map.StringMapEntry = null,

    /// The unique identifier of the route.
    ///
    /// **DEFAULT**: All traffic that does not match another route is
    /// forwarded to the default route. Applications must have a default route
    /// before any other routes
    /// can be created.
    ///
    /// **URI_PATH**: A route that is based on a URI path.
    route_id: ?[]const u8 = null,

    /// The type of route.
    route_type: ?RouteType = null,

    /// The unique identifier of the service.
    service_id: ?[]const u8 = null,

    /// This is the path that Refactor Spaces uses to match traffic. Paths must
    /// start with `/` and are relative to
    /// the base of the application. To use path parameters in the source path, add
    /// a variable in curly braces.
    /// For example, the resource path {user} represents a path parameter called
    /// 'user'.
    source_path: ?[]const u8 = null,

    /// The current state of the route.
    state: ?RouteState = null,

    /// The tags assigned to the route. A tag is a label that you assign to an
    /// Amazon Web Services resource. Each tag consists of a key-value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .append_source_path = "AppendSourcePath",
        .application_id = "ApplicationId",
        .arn = "Arn",
        .created_by_account_id = "CreatedByAccountId",
        .created_time = "CreatedTime",
        .environment_id = "EnvironmentId",
        .@"error" = "Error",
        .include_child_paths = "IncludeChildPaths",
        .last_updated_time = "LastUpdatedTime",
        .methods = "Methods",
        .owner_account_id = "OwnerAccountId",
        .path_resource_to_id = "PathResourceToId",
        .route_id = "RouteId",
        .route_type = "RouteType",
        .service_id = "ServiceId",
        .source_path = "SourcePath",
        .state = "State",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRouteInput, options: CallOptions) !GetRouteOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRouteInput, config: *aws.Config) !aws.http.Request {
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRouteOutput {
    var result: GetRouteOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRouteOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
