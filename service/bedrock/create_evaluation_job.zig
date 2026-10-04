const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationType = @import("application_type.zig").ApplicationType;
const EvaluationConfig = @import("evaluation_config.zig").EvaluationConfig;
const EvaluationInferenceConfig = @import("evaluation_inference_config.zig").EvaluationInferenceConfig;
const Tag = @import("tag.zig").Tag;
const EvaluationOutputDataConfig = @import("evaluation_output_data_config.zig").EvaluationOutputDataConfig;

pub const CreateEvaluationJobInput = struct {
    /// Specifies whether the evaluation job is for evaluating a model or evaluating
    /// a knowledge base (retrieval and response generation).
    application_type: ?ApplicationType = null,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_request_token: ?[]const u8 = null,

    /// Specify your customer managed encryption key Amazon Resource Name (ARN) that
    /// will be used to encrypt your evaluation job.
    customer_encryption_key_id: ?[]const u8 = null,

    /// Contains the configuration details of either an automated or human-based
    /// evaluation job.
    evaluation_config: EvaluationConfig,

    /// Contains the configuration details of the inference model for the evaluation
    /// job.
    ///
    /// For model evaluation jobs, automated jobs support a single model or
    /// [inference
    /// profile](https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html), and jobs that use human workers support two models or inference profiles.
    inference_config: EvaluationInferenceConfig,

    /// A description of the evaluation job.
    job_description: ?[]const u8 = null,

    /// A name for the evaluation job. Names must unique with your Amazon Web
    /// Services account, and your account's Amazon Web Services region.
    job_name: []const u8,

    /// Tags to attach to the model evaluation job.
    job_tags: ?[]const Tag = null,

    /// Contains the configuration details of the Amazon S3 bucket for storing the
    /// results of the evaluation job.
    output_data_config: EvaluationOutputDataConfig,

    /// The Amazon Resource Name (ARN) of an IAM service role that Amazon Bedrock
    /// can assume to perform tasks on your behalf. To learn more about the required
    /// permissions, see [Required permissions for model
    /// evaluations](https://docs.aws.amazon.com/bedrock/latest/userguide/model-evaluation-security.html).
    role_arn: []const u8,

    pub const json_field_names = .{
        .application_type = "applicationType",
        .client_request_token = "clientRequestToken",
        .customer_encryption_key_id = "customerEncryptionKeyId",
        .evaluation_config = "evaluationConfig",
        .inference_config = "inferenceConfig",
        .job_description = "jobDescription",
        .job_name = "jobName",
        .job_tags = "jobTags",
        .output_data_config = "outputDataConfig",
        .role_arn = "roleArn",
    };
};

pub const CreateEvaluationJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the evaluation job.
    job_arn: []const u8,

    pub const json_field_names = .{
        .job_arn = "jobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEvaluationJobInput, options: CallOptions) !CreateEvaluationJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEvaluationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/evaluation-jobs";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.application_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"applicationType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.customer_encryption_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customerEncryptionKeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"evaluationConfig\":");
    try aws.json.writeValue(@TypeOf(input.evaluation_config), input.evaluation_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"inferenceConfig\":");
    try aws.json.writeValue(@TypeOf(input.inference_config), input.inference_config, allocator, &body_buf);
    has_prev = true;
    if (input.job_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobName\":");
    try aws.json.writeValue(@TypeOf(input.job_name), input.job_name, allocator, &body_buf);
    has_prev = true;
    if (input.job_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"outputDataConfig\":");
    try aws.json.writeValue(@TypeOf(input.output_data_config), input.output_data_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEvaluationJobOutput {
    const result: CreateEvaluationJobOutput = try aws.json.parseJsonObject(
        CreateEvaluationJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
