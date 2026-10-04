const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CloudConnectorConfiguration = @import("cloud_connector_configuration.zig").CloudConnectorConfiguration;

pub const UpdateCloudConnectorInput = struct {
    /// The ID of the cloud connector to update.
    cloud_connector_id: []const u8,

    /// The updated configuration details for connecting to the third-party cloud
    /// environment.
    configuration: ?CloudConnectorConfiguration = null,

    /// A new description for the cloud connector.
    description: ?[]const u8 = null,

    /// A new friendly name for the cloud connector.
    display_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_connector_id = "CloudConnectorId",
        .configuration = "Configuration",
        .description = "Description",
        .display_name = "DisplayName",
    };
};

pub const UpdateCloudConnectorOutput = struct {
    /// The ID of the cloud connector that was updated.
    cloud_connector_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_connector_id = "CloudConnectorId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCloudConnectorInput, options: CallOptions) !UpdateCloudConnectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCloudConnectorInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.UpdateCloudConnector");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCloudConnectorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateCloudConnectorOutput, body, allocator);
}
