const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProjectVersionStatus = @import("project_version_status.zig").ProjectVersionStatus;

pub const StartProjectVersionInput = struct {
    /// The maximum number of inference units to use for auto-scaling the model. If
    /// you don't
    /// specify a value, Amazon Rekognition Custom Labels doesn't auto-scale the
    /// model.
    max_inference_units: ?i32 = null,

    /// The minimum number of inference units to use. A single
    /// inference unit represents 1 hour of processing.
    ///
    /// Use a higher number to increase the TPS throughput of your model. You are
    /// charged for the number
    /// of inference units that you use.
    min_inference_units: i32,

    /// The Amazon Resource Name(ARN) of the model version that you want to start.
    project_version_arn: []const u8,

    pub const json_field_names = .{
        .max_inference_units = "MaxInferenceUnits",
        .min_inference_units = "MinInferenceUnits",
        .project_version_arn = "ProjectVersionArn",
    };
};

pub const StartProjectVersionOutput = struct {
    /// The current running status of the model.
    status: ?ProjectVersionStatus = null,

    pub const json_field_names = .{
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartProjectVersionInput, options: CallOptions) !StartProjectVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rekognition", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartProjectVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rekognition", "Rekognition", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.StartProjectVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartProjectVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartProjectVersionOutput, body, allocator);
}
