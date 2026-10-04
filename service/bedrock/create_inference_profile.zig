const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InferenceProfileModelSource = @import("inference_profile_model_source.zig").InferenceProfileModelSource;
const Tag = @import("tag.zig").Tag;
const InferenceProfileStatus = @import("inference_profile_status.zig").InferenceProfileStatus;

pub const CreateInferenceProfileInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_request_token: ?[]const u8 = null,

    /// A description for the inference profile.
    description: ?[]const u8 = null,

    /// A name for the inference profile.
    inference_profile_name: []const u8,

    /// The foundation model or system-defined inference profile that the inference
    /// profile will track metrics and costs for.
    model_source: InferenceProfileModelSource,

    /// An array of objects, each of which contains a tag and its value. For more
    /// information, see [Tagging
    /// resources](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .description = "description",
        .inference_profile_name = "inferenceProfileName",
        .model_source = "modelSource",
        .tags = "tags",
    };
};

pub const CreateInferenceProfileOutput = struct {
    /// The ARN of the inference profile that you created.
    inference_profile_arn: []const u8,

    /// The status of the inference profile. `ACTIVE` means that the inference
    /// profile is ready to be used.
    status: ?InferenceProfileStatus = null,

    pub const json_field_names = .{
        .inference_profile_arn = "inferenceProfileArn",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInferenceProfileInput, options: CallOptions) !CreateInferenceProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateInferenceProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/inference-profiles";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"inferenceProfileName\":");
    try aws.json.writeValue(@TypeOf(input.inference_profile_name), input.inference_profile_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"modelSource\":");
    try aws.json.writeValue(@TypeOf(input.model_source), input.model_source, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateInferenceProfileOutput {
    const result: CreateInferenceProfileOutput = try aws.json.parseJsonObject(
        CreateInferenceProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
