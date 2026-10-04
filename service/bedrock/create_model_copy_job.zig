const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateModelCopyJobInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_request_token: ?[]const u8 = null,

    /// The ARN of the KMS key that you use to encrypt the model copy.
    model_kms_key_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the model to be copied.
    source_model_arn: []const u8,

    /// A name for the copied model.
    target_model_name: []const u8,

    /// Tags to associate with the target model. For more information, see [Tag
    /// resources](https://docs.aws.amazon.com/bedrock/latest/userguide/tagging.html) in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-service.html).
    target_model_tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .model_kms_key_id = "modelKmsKeyId",
        .source_model_arn = "sourceModelArn",
        .target_model_name = "targetModelName",
        .target_model_tags = "targetModelTags",
    };
};

pub const CreateModelCopyJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the model copy job.
    job_arn: []const u8,

    pub const json_field_names = .{
        .job_arn = "jobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateModelCopyJobInput, options: CallOptions) !CreateModelCopyJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateModelCopyJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/model-copy-jobs";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.model_kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"modelKmsKeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceModelArn\":");
    try aws.json.writeValue(@TypeOf(input.source_model_arn), input.source_model_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetModelName\":");
    try aws.json.writeValue(@TypeOf(input.target_model_name), input.target_model_name, allocator, &body_buf);
    has_prev = true;
    if (input.target_model_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"targetModelTags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateModelCopyJobOutput {
    var result: CreateModelCopyJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateModelCopyJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
