const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LanguageModel = @import("language_model.zig").LanguageModel;

pub const DescribeLanguageModelInput = struct {
    /// The name of the custom language model you want information about. Model
    /// names are case
    /// sensitive.
    model_name: []const u8,

    pub const json_field_names = .{
        .model_name = "ModelName",
    };
};

pub const DescribeLanguageModelOutput = struct {
    /// Provides information about the specified custom language model.
    ///
    /// This parameter also shows if the base language model you used to create your
    /// custom
    /// language model has been updated. If Amazon Transcribe has updated the base
    /// model, you
    /// can create a new custom language model using the updated base model.
    ///
    /// If you tried to create a new custom language model and the request wasn't
    /// successful,
    /// you can use this `DescribeLanguageModel` to help identify the reason for
    /// this
    /// failure.
    language_model: ?LanguageModel = null,

    pub const json_field_names = .{
        .language_model = "LanguageModel",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLanguageModelInput, options: CallOptions) !DescribeLanguageModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "transcribe", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLanguageModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transcribe", "Transcribe", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Transcribe.DescribeLanguageModel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLanguageModelOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeLanguageModelOutput, body, allocator);
}
