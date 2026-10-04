const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CloudConnectorConfiguration = @import("cloud_connector_configuration.zig").CloudConnectorConfiguration;

pub const GetCloudConnectorInput = struct {
    /// The ID of the cloud connector to retrieve information about.
    cloud_connector_id: []const u8,

    pub const json_field_names = .{
        .cloud_connector_id = "CloudConnectorId",
    };
};

pub const GetCloudConnectorOutput = struct {
    /// The ARN of the cloud connector.
    cloud_connector_arn: ?[]const u8 = null,

    /// The ARN of the Amazon Web Services Config connector associated with this
    /// cloud connector.
    config_connector_arn: ?[]const u8 = null,

    /// The configuration details for the third-party cloud environment connection.
    configuration: ?CloudConnectorConfiguration = null,

    /// The date and time the cloud connector was created.
    created_at: ?i64 = null,

    /// The description of the cloud connector.
    description: ?[]const u8 = null,

    /// The friendly name of the cloud connector.
    display_name: ?[]const u8 = null,

    /// The ARN of the IAM role used by the cloud connector.
    role_arn: ?[]const u8 = null,

    /// The date and time the cloud connector was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .cloud_connector_arn = "CloudConnectorArn",
        .config_connector_arn = "ConfigConnectorArn",
        .configuration = "Configuration",
        .created_at = "CreatedAt",
        .description = "Description",
        .display_name = "DisplayName",
        .role_arn = "RoleArn",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCloudConnectorInput, options: CallOptions) !GetCloudConnectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCloudConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.GetCloudConnector");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCloudConnectorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCloudConnectorOutput, body, allocator);
}
