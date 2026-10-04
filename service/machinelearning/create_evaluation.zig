const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateEvaluationInput = struct {
    /// The ID of the `DataSource` for the evaluation. The schema of the
    /// `DataSource`
    /// must match the schema used to create the `MLModel`.
    evaluation_data_source_id: []const u8,

    /// A user-supplied ID that uniquely identifies the `Evaluation`.
    evaluation_id: []const u8,

    /// A user-supplied name or description of the `Evaluation`.
    evaluation_name: ?[]const u8 = null,

    /// The ID of the `MLModel` to evaluate.
    ///
    /// The schema used in creating the `MLModel` must match the schema of the
    /// `DataSource` used in the `Evaluation`.
    ml_model_id: []const u8,

    pub const json_field_names = .{
        .evaluation_data_source_id = "EvaluationDataSourceId",
        .evaluation_id = "EvaluationId",
        .evaluation_name = "EvaluationName",
        .ml_model_id = "MLModelId",
    };
};

pub const CreateEvaluationOutput = struct {
    /// The user-supplied ID that uniquely identifies the `Evaluation`. This value
    /// should be identical to the value of the
    /// `EvaluationId` in the request.
    evaluation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .evaluation_id = "EvaluationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEvaluationInput, options: CallOptions) !CreateEvaluationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEvaluationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonML_20141212.CreateEvaluation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEvaluationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateEvaluationOutput, body, allocator);
}
