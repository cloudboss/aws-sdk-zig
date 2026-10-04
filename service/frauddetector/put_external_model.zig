const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ModelInputConfiguration = @import("model_input_configuration.zig").ModelInputConfiguration;
const ModelEndpointStatus = @import("model_endpoint_status.zig").ModelEndpointStatus;
const ModelSource = @import("model_source.zig").ModelSource;
const ModelOutputConfiguration = @import("model_output_configuration.zig").ModelOutputConfiguration;
const Tag = @import("tag.zig").Tag;

pub const PutExternalModelInput = struct {
    /// The model endpoint input configuration.
    input_configuration: ModelInputConfiguration,

    /// The IAM role used to invoke the model endpoint.
    invoke_model_endpoint_role_arn: []const u8,

    /// The model endpoints name.
    model_endpoint: []const u8,

    /// The model endpoint’s status in Amazon Fraud Detector.
    model_endpoint_status: ModelEndpointStatus,

    /// The source of the model.
    model_source: ModelSource,

    /// The model endpoint output configuration.
    output_configuration: ModelOutputConfiguration,

    /// A collection of key and value pairs.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .input_configuration = "inputConfiguration",
        .invoke_model_endpoint_role_arn = "invokeModelEndpointRoleArn",
        .model_endpoint = "modelEndpoint",
        .model_endpoint_status = "modelEndpointStatus",
        .model_source = "modelSource",
        .output_configuration = "outputConfiguration",
        .tags = "tags",
    };
};

pub const PutExternalModelOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutExternalModelInput, options: CallOptions) !PutExternalModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "frauddetector", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutExternalModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("frauddetector", "FraudDetector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSHawksNestServiceFacade.PutExternalModel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutExternalModelOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
