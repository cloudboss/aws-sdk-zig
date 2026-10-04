const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ParameterConstraints = @import("parameter_constraints.zig").ParameterConstraints;

pub const GetRouteResponseInput = struct {
    /// The API identifier.
    api_id: []const u8,

    /// The route ID.
    route_id: []const u8,

    /// The route response ID.
    route_response_id: []const u8,

    pub const json_field_names = .{
        .api_id = "ApiId",
        .route_id = "RouteId",
        .route_response_id = "RouteResponseId",
    };
};

pub const GetRouteResponseOutput = struct {
    /// Represents the model selection expression of a route response. Supported
    /// only for WebSocket APIs.
    model_selection_expression: ?[]const u8 = null,

    /// Represents the response models of a route response.
    response_models: ?[]const aws.map.StringMapEntry = null,

    /// Represents the response parameters of a route response.
    response_parameters: ?[]const aws.map.MapEntry(ParameterConstraints) = null,

    /// Represents the identifier of a route response.
    route_response_id: ?[]const u8 = null,

    /// Represents the route response key of a route response.
    route_response_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_selection_expression = "ModelSelectionExpression",
        .response_models = "ResponseModels",
        .response_parameters = "ResponseParameters",
        .route_response_id = "RouteResponseId",
        .route_response_key = "RouteResponseKey",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRouteResponseInput, options: CallOptions) !GetRouteResponseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRouteResponseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    try path_buf.appendSlice(allocator, "/routes/");
    try path_buf.appendSlice(allocator, input.route_id);
    try path_buf.appendSlice(allocator, "/routeresponses/");
    try path_buf.appendSlice(allocator, input.route_response_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRouteResponseOutput {
    const result: GetRouteResponseOutput = try aws.json.parseJsonObject(
        GetRouteResponseOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
