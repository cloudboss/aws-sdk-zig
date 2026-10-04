const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ModelCustomization = @import("model_customization.zig").ModelCustomization;
const InferenceType = @import("inference_type.zig").InferenceType;
const ModelModality = @import("model_modality.zig").ModelModality;
const FoundationModelSummary = @import("foundation_model_summary.zig").FoundationModelSummary;

pub const ListFoundationModelsInput = struct {
    /// Return models that support the customization type that you specify. For more
    /// information, see [Custom
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/custom-models.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    by_customization_type: ?ModelCustomization = null,

    /// Return models that support the inference type that you specify. For more
    /// information, see [Provisioned
    /// Throughput](https://docs.aws.amazon.com/bedrock/latest/userguide/prov-throughput.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    by_inference_type: ?InferenceType = null,

    /// Return models that support the output modality that you specify.
    by_output_modality: ?ModelModality = null,

    /// Return models belonging to the model provider that you specify.
    by_provider: ?[]const u8 = null,

    pub const json_field_names = .{
        .by_customization_type = "byCustomizationType",
        .by_inference_type = "byInferenceType",
        .by_output_modality = "byOutputModality",
        .by_provider = "byProvider",
    };
};

pub const ListFoundationModelsOutput = struct {
    /// A list of Amazon Bedrock foundation models.
    model_summaries: ?[]const FoundationModelSummary = null,

    pub const json_field_names = .{
        .model_summaries = "modelSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFoundationModelsInput, options: CallOptions) !ListFoundationModelsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFoundationModelsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/foundation-models";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.by_customization_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "byCustomizationType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.by_inference_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "byInferenceType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.by_output_modality) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "byOutputModality=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.by_provider) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "byProvider=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFoundationModelsOutput {
    const result: ListFoundationModelsOutput = try aws.json.parseJsonObject(
        ListFoundationModelsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
