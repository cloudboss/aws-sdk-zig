const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceEndpointType = @import("service_endpoint_type.zig").ServiceEndpointType;
const ErrorResponse = @import("error_response.zig").ErrorResponse;
const LambdaEndpointConfig = @import("lambda_endpoint_config.zig").LambdaEndpointConfig;
const ServiceState = @import("service_state.zig").ServiceState;
const UrlEndpointConfig = @import("url_endpoint_config.zig").UrlEndpointConfig;

pub const GetServiceInput = struct {
    /// The ID of the application.
    application_identifier: []const u8,

    /// The ID of the environment.
    environment_identifier: []const u8,

    /// The ID of the service.
    service_identifier: []const u8,

    pub const json_field_names = .{
        .application_identifier = "ApplicationIdentifier",
        .environment_identifier = "EnvironmentIdentifier",
        .service_identifier = "ServiceIdentifier",
    };
};

pub const GetServiceOutput = struct {
    /// The ID of the application.
    application_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the service.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the service creator.
    created_by_account_id: ?[]const u8 = null,

    /// The timestamp of when the service is created.
    created_time: ?i64 = null,

    /// The description of the service.
    description: ?[]const u8 = null,

    /// The endpoint type of the service.
    endpoint_type: ?ServiceEndpointType = null,

    /// The unique identifier of the environment.
    environment_id: ?[]const u8 = null,

    /// Any error associated with the service resource.
    @"error": ?ErrorResponse = null,

    /// The configuration for the Lambda endpoint type.
    ///
    /// The **Arn** is the Amazon Resource Name (ARN) of the Lambda function
    /// associated with this service.
    lambda_endpoint: ?LambdaEndpointConfig = null,

    /// A timestamp that indicates when the service was last updated.
    last_updated_time: ?i64 = null,

    /// The name of the service.
    name: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the service owner.
    owner_account_id: ?[]const u8 = null,

    /// The unique identifier of the service.
    service_id: ?[]const u8 = null,

    /// The current state of the service.
    state: ?ServiceState = null,

    /// The tags assigned to the service. A tag is a label that you assign to an
    /// Amazon Web Services resource. Each tag consists of a key-value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The configuration for the URL endpoint type.
    ///
    /// The **Url** isthe URL of the endpoint type.
    ///
    /// The **HealthUrl** is the health check URL of the endpoint
    /// type.
    url_endpoint: ?UrlEndpointConfig = null,

    /// The ID of the virtual private cloud (VPC).
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .arn = "Arn",
        .created_by_account_id = "CreatedByAccountId",
        .created_time = "CreatedTime",
        .description = "Description",
        .endpoint_type = "EndpointType",
        .environment_id = "EnvironmentId",
        .@"error" = "Error",
        .lambda_endpoint = "LambdaEndpoint",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .owner_account_id = "OwnerAccountId",
        .service_id = "ServiceId",
        .state = "State",
        .tags = "Tags",
        .url_endpoint = "UrlEndpoint",
        .vpc_id = "VpcId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetServiceInput, options: CallOptions) !GetServiceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetServiceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("refactor-spaces", "Migration Hub Refactor Spaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.environment_identifier);
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_identifier);
    try path_buf.appendSlice(allocator, "/services/");
    try path_buf.appendSlice(allocator, input.service_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetServiceOutput {
    const result: GetServiceOutput = try aws.json.parseJsonObject(
        GetServiceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
