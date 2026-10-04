const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationRecorderStatus = @import("configuration_recorder_status.zig").ConfigurationRecorderStatus;

pub const DescribeConfigurationRecorderStatusInput = struct {
    /// The Amazon Resource Name (ARN) of the configuration recorder that you want
    /// to specify.
    arn: ?[]const u8 = null,

    /// The name of the configuration recorder. If the name is not
    /// specified, the operation returns the status for the customer managed
    /// configuration recorder configured for the
    /// account, if applicable.
    ///
    /// When making a request to this operation, you can only specify one
    /// configuration recorder.
    configuration_recorder_names: ?[]const []const u8 = null,

    /// For service-linked configuration recorders, you can use the service
    /// principal of the linked Amazon Web Services service to specify the
    /// configuration recorder. This field is only supported for Amazon Web Services
    /// service principals. For third-party service-linked configuration recorders,
    /// use `Arn` instead.
    service_principal: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .configuration_recorder_names = "ConfigurationRecorderNames",
        .service_principal = "ServicePrincipal",
    };
};

pub const DescribeConfigurationRecorderStatusOutput = struct {
    /// A list that contains status of the specified
    /// recorders.
    configuration_recorders_status: ?[]const ConfigurationRecorderStatus = null,

    pub const json_field_names = .{
        .configuration_recorders_status = "ConfigurationRecordersStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConfigurationRecorderStatusInput, options: CallOptions) !DescribeConfigurationRecorderStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConfigurationRecorderStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.DescribeConfigurationRecorderStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConfigurationRecorderStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeConfigurationRecorderStatusOutput, body, allocator);
}
