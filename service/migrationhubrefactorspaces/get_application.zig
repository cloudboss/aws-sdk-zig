const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApiGatewayProxyConfig = @import("api_gateway_proxy_config.zig").ApiGatewayProxyConfig;
const ErrorResponse = @import("error_response.zig").ErrorResponse;
const ProxyType = @import("proxy_type.zig").ProxyType;
const ApplicationState = @import("application_state.zig").ApplicationState;

pub const GetApplicationInput = struct {
    /// The ID of the application.
    application_identifier: []const u8,

    /// The ID of the environment.
    environment_identifier: []const u8,

    pub const json_field_names = .{
        .application_identifier = "ApplicationIdentifier",
        .environment_identifier = "EnvironmentIdentifier",
    };
};

pub const GetApplicationOutput = struct {
    /// The endpoint URL of the API Gateway proxy.
    api_gateway_proxy: ?ApiGatewayProxyConfig = null,

    /// The unique identifier of the application.
    application_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the application.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the application creator.
    created_by_account_id: ?[]const u8 = null,

    /// A timestamp that indicates when the application is created.
    created_time: ?i64 = null,

    /// The unique identifier of the environment.
    environment_id: ?[]const u8 = null,

    /// Any error associated with the application resource.
    @"error": ?ErrorResponse = null,

    /// A timestamp that indicates when the application was last updated.
    last_updated_time: ?i64 = null,

    /// The name of the application.
    name: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the application owner (which is always
    /// the same as
    /// the environment owner account ID).
    owner_account_id: ?[]const u8 = null,

    /// The proxy type of the proxy created within the application.
    proxy_type: ?ProxyType = null,

    /// The current state of the application.
    state: ?ApplicationState = null,

    /// The tags assigned to the application. A tag is a label that you assign to an
    /// Amazon Web Services resource. Each tag consists of a key-value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the virtual private cloud (VPC).
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_gateway_proxy = "ApiGatewayProxy",
        .application_id = "ApplicationId",
        .arn = "Arn",
        .created_by_account_id = "CreatedByAccountId",
        .created_time = "CreatedTime",
        .environment_id = "EnvironmentId",
        .@"error" = "Error",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .owner_account_id = "OwnerAccountId",
        .proxy_type = "ProxyType",
        .state = "State",
        .tags = "Tags",
        .vpc_id = "VpcId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetApplicationInput, options: CallOptions) !GetApplicationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("refactor-spaces", "Migration Hub Refactor Spaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.environment_identifier);
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetApplicationOutput {
    const result: GetApplicationOutput = try aws.json.parseJsonObject(
        GetApplicationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
