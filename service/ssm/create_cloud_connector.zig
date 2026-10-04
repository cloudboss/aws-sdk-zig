const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CloudConnectorConfiguration = @import("cloud_connector_configuration.zig").CloudConnectorConfiguration;
const Tag = @import("tag.zig").Tag;

pub const CreateCloudConnectorInput = struct {
    /// The ARN of the Amazon Web Services Config connector associated with this
    /// cloud connector.
    config_connector_arn: []const u8,

    /// The configuration details for connecting to the third-party cloud
    /// environment.
    configuration: CloudConnectorConfiguration,

    /// A description for the cloud connector.
    description: ?[]const u8 = null,

    /// A friendly name for the cloud connector.
    display_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role that the cloud connector
    /// uses to communicate with the third-party cloud environment.
    role_arn: []const u8,

    /// Optional metadata that you assign to a resource. Tags enable you to
    /// categorize a resource
    /// in different ways, such as by purpose, owner, or environment.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .config_connector_arn = "ConfigConnectorArn",
        .configuration = "Configuration",
        .description = "Description",
        .display_name = "DisplayName",
        .role_arn = "RoleArn",
        .tags = "Tags",
    };
};

pub const CreateCloudConnectorOutput = struct {
    /// The ID of the cloud connector that was created.
    cloud_connector_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_connector_id = "CloudConnectorId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCloudConnectorInput, options: CallOptions) !CreateCloudConnectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCloudConnectorInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.CreateCloudConnector");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCloudConnectorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCloudConnectorOutput, body, allocator);
}
