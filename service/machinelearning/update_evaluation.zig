const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateEvaluationInput = struct {
    /// The ID assigned to the `Evaluation` during creation.
    evaluation_id: []const u8,

    /// A new user-supplied name or description of the `Evaluation` that will
    /// replace the current content.
    evaluation_name: []const u8,

    pub const json_field_names = .{
        .evaluation_id = "EvaluationId",
        .evaluation_name = "EvaluationName",
    };
};

pub const UpdateEvaluationOutput = struct {
    /// The ID assigned to the `Evaluation` during creation. This value should be
    /// identical to the value
    /// of the `Evaluation` in the request.
    evaluation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .evaluation_id = "EvaluationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEvaluationInput, options: CallOptions) !UpdateEvaluationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEvaluationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonML_20141212.UpdateEvaluation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEvaluationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateEvaluationOutput, body, allocator);
}
