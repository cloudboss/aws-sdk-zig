const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateBatchPredictionInput = struct {
    /// The ID assigned to the `BatchPrediction` during creation.
    batch_prediction_id: []const u8,

    /// A new user-supplied name or description of the `BatchPrediction`.
    batch_prediction_name: []const u8,

    pub const json_field_names = .{
        .batch_prediction_id = "BatchPredictionId",
        .batch_prediction_name = "BatchPredictionName",
    };
};

pub const UpdateBatchPredictionOutput = struct {
    /// The ID assigned to the `BatchPrediction` during creation. This value should
    /// be identical to the value
    /// of the `BatchPredictionId` in the request.
    batch_prediction_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .batch_prediction_id = "BatchPredictionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBatchPredictionInput, options: CallOptions) !UpdateBatchPredictionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "machinelearning", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBatchPredictionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("machinelearning", "Machine Learning", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonML_20141212.UpdateBatchPrediction");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBatchPredictionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateBatchPredictionOutput, body, allocator);
}
