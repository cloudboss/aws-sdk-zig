const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessLogSettings = @import("access_log_settings.zig").AccessLogSettings;
const RouteSettings = @import("route_settings.zig").RouteSettings;

pub const GetStageInput = struct {
    /// The API identifier.
    api_id: []const u8,

    /// The stage name. Stage names can only contain alphanumeric characters,
    /// hyphens, and underscores. Maximum length is 128 characters.
    stage_name: []const u8,

    pub const json_field_names = .{
        .api_id = "ApiId",
        .stage_name = "StageName",
    };
};

pub const GetStageOutput = struct {
    /// Settings for logging access in this stage.
    access_log_settings: ?AccessLogSettings = null,

    /// Specifies whether a stage is managed by API Gateway. If you created an API
    /// using quick create, the $default stage is managed by API Gateway. You can't
    /// modify the $default stage.
    api_gateway_managed: ?bool = null,

    /// Specifies whether updates to an API automatically trigger a new deployment.
    /// The default value is false.
    auto_deploy: ?bool = null,

    /// The identifier of a client certificate for a Stage. Supported only for
    /// WebSocket APIs.
    client_certificate_id: ?[]const u8 = null,

    /// The timestamp when the stage was created.
    created_date: ?i64 = null,

    /// Default route settings for the stage.
    default_route_settings: ?RouteSettings = null,

    /// The identifier of the Deployment that the Stage is associated with. Can't be
    /// updated if autoDeploy is enabled.
    deployment_id: ?[]const u8 = null,

    /// The description of the stage.
    description: ?[]const u8 = null,

    /// Describes the status of the last deployment of a stage. Supported only for
    /// stages with autoDeploy enabled.
    last_deployment_status_message: ?[]const u8 = null,

    /// The timestamp when the stage was last updated.
    last_updated_date: ?i64 = null,

    /// Route settings for the stage, by routeKey.
    route_settings: ?[]const aws.map.MapEntry(RouteSettings) = null,

    /// The name of the stage.
    stage_name: ?[]const u8 = null,

    /// A map that defines the stage variables for a stage resource. Variable names
    /// can have alphanumeric and underscore characters, and the values must match
    /// [A-Za-z0-9-._~:/?#&=,]+.
    stage_variables: ?[]const aws.map.StringMapEntry = null,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .access_log_settings = "AccessLogSettings",
        .api_gateway_managed = "ApiGatewayManaged",
        .auto_deploy = "AutoDeploy",
        .client_certificate_id = "ClientCertificateId",
        .created_date = "CreatedDate",
        .default_route_settings = "DefaultRouteSettings",
        .deployment_id = "DeploymentId",
        .description = "Description",
        .last_deployment_status_message = "LastDeploymentStatusMessage",
        .last_updated_date = "LastUpdatedDate",
        .route_settings = "RouteSettings",
        .stage_name = "StageName",
        .stage_variables = "StageVariables",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetStageInput, options: CallOptions) !GetStageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetStageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    try path_buf.appendSlice(allocator, "/stages/");
    try path_buf.appendSlice(allocator, input.stage_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetStageOutput {
    var result: GetStageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetStageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
