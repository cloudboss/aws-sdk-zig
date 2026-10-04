const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InputConfiguration = @import("input_configuration.zig").InputConfiguration;

pub const StartApplicationInput = struct {
    /// Name of the application.
    application_name: []const u8,

    /// Identifies the specific input, by ID, that the application starts consuming.
    /// Amazon Kinesis Analytics starts reading the streaming source associated with
    /// the input. You can also specify where in the streaming source you want
    /// Amazon Kinesis Analytics to start reading.
    input_configurations: []const InputConfiguration,

    pub const json_field_names = .{
        .application_name = "ApplicationName",
        .input_configurations = "InputConfigurations",
    };
};

pub const StartApplicationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartApplicationInput, options: CallOptions) !StartApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesisanalytics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisanalytics", "Kinesis Analytics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "KinesisAnalytics_20150814.StartApplication");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartApplicationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
