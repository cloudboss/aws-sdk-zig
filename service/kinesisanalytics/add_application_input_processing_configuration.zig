const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InputProcessingConfiguration = @import("input_processing_configuration.zig").InputProcessingConfiguration;

pub const AddApplicationInputProcessingConfigurationInput = struct {
    /// Name of the application to which you want to add the input processing
    /// configuration.
    application_name: []const u8,

    /// Version of the application to which you want to add the input processing
    /// configuration. You can use the
    /// [DescribeApplication](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_DescribeApplication.html)
    /// operation to get the current application version. If the version specified
    /// is not the current version, the
    /// `ConcurrentModificationException` is returned.
    current_application_version_id: i64,

    /// The ID of the input configuration to add the input processing configuration
    /// to. You
    /// can get a list of the input IDs for an application using the
    /// [DescribeApplication](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_DescribeApplication.html) operation.
    input_id: []const u8,

    /// The
    /// [InputProcessingConfiguration](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_InputProcessingConfiguration.html) to add to the application.
    input_processing_configuration: InputProcessingConfiguration,

    pub const json_field_names = .{
        .application_name = "ApplicationName",
        .current_application_version_id = "CurrentApplicationVersionId",
        .input_id = "InputId",
        .input_processing_configuration = "InputProcessingConfiguration",
    };
};

pub const AddApplicationInputProcessingConfigurationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddApplicationInputProcessingConfigurationInput, options: CallOptions) !AddApplicationInputProcessingConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AddApplicationInputProcessingConfigurationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "KinesisAnalytics_20150814.AddApplicationInputProcessingConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddApplicationInputProcessingConfigurationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
