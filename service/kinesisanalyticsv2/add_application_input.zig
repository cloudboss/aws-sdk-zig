const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Input = @import("input.zig").Input;
const InputDescription = @import("input_description.zig").InputDescription;

pub const AddApplicationInputInput = struct {
    /// The name of your existing application to which you want to add the streaming
    /// source.
    application_name: []const u8,

    /// The current version of your application.
    /// You must provide the `ApplicationVersionID` or the `ConditionalToken`.You
    /// can use the DescribeApplication operation to find the current application
    /// version.
    current_application_version_id: i64,

    /// The Input to add.
    input: Input,

    pub const json_field_names = .{
        .application_name = "ApplicationName",
        .current_application_version_id = "CurrentApplicationVersionId",
        .input = "Input",
    };
};

pub const AddApplicationInputOutput = struct {
    /// The Amazon Resource Name (ARN) of the application.
    application_arn: ?[]const u8 = null,

    /// Provides the current application version.
    application_version_id: ?i64 = null,

    /// Describes the application input configuration.
    input_descriptions: ?[]const InputDescription = null,

    pub const json_field_names = .{
        .application_arn = "ApplicationARN",
        .application_version_id = "ApplicationVersionId",
        .input_descriptions = "InputDescriptions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddApplicationInputInput, options: CallOptions) !AddApplicationInputOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AddApplicationInputInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisanalytics", "Kinesis Analytics V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "KinesisAnalytics_20180523.AddApplicationInput");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddApplicationInputOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AddApplicationInputOutput, body, allocator);
}
