const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ModelInvocationJobInputDataConfig = @import("model_invocation_job_input_data_config.zig").ModelInvocationJobInputDataConfig;
const ModelInvocationType = @import("model_invocation_type.zig").ModelInvocationType;
const ModelInvocationJobOutputDataConfig = @import("model_invocation_job_output_data_config.zig").ModelInvocationJobOutputDataConfig;
const Tag = @import("tag.zig").Tag;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

pub const CreateModelInvocationJobInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_request_token: ?[]const u8 = null,

    /// Details about the location of the input to the batch inference job.
    input_data_config: ModelInvocationJobInputDataConfig,

    /// A name to give the batch inference job.
    job_name: []const u8,

    /// The unique identifier of the foundation model to use for the batch inference
    /// job.
    model_id: []const u8,

    /// The invocation endpoint for ModelInvocationJob
    model_invocation_type: ?ModelInvocationType = null,

    /// Details about the location of the output of the batch inference job.
    output_data_config: ModelInvocationJobOutputDataConfig,

    /// The Amazon Resource Name (ARN) of the service role with permissions to carry
    /// out and manage batch inference. You can use the console to create a default
    /// service role or follow the steps at [Create a service role for batch
    /// inference](https://docs.aws.amazon.com/bedrock/latest/userguide/batch-iam-sr.html).
    role_arn: []const u8,

    /// Any tags to associate with the batch inference job. For more information,
    /// see [Tagging Amazon Bedrock
    /// resources](https://docs.aws.amazon.com/bedrock/latest/userguide/tagging.html).
    tags: ?[]const Tag = null,

    /// The number of hours after which to force the batch inference job to time
    /// out.
    timeout_duration_in_hours: ?i32 = null,

    /// The configuration of the Virtual Private Cloud (VPC) for the data in the
    /// batch inference job. For more information, see [Protect batch inference jobs
    /// using a
    /// VPC](https://docs.aws.amazon.com/bedrock/latest/userguide/batch-vpc).
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .input_data_config = "inputDataConfig",
        .job_name = "jobName",
        .model_id = "modelId",
        .model_invocation_type = "modelInvocationType",
        .output_data_config = "outputDataConfig",
        .role_arn = "roleArn",
        .tags = "tags",
        .timeout_duration_in_hours = "timeoutDurationInHours",
        .vpc_config = "vpcConfig",
    };
};

pub const CreateModelInvocationJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the batch inference job.
    job_arn: []const u8,

    pub const json_field_names = .{
        .job_arn = "jobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateModelInvocationJobInput, options: CallOptions) !CreateModelInvocationJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateModelInvocationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/model-invocation-job";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"inputDataConfig\":");
    try aws.json.writeValue(@TypeOf(input.input_data_config), input.input_data_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobName\":");
    try aws.json.writeValue(@TypeOf(input.job_name), input.job_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"modelId\":");
    try aws.json.writeValue(@TypeOf(input.model_id), input.model_id, allocator, &body_buf);
    has_prev = true;
    if (input.model_invocation_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"modelInvocationType\":");
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
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.timeout_duration_in_hours) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"timeoutDurationInHours\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"vpcConfig\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateModelInvocationJobOutput {
    const result: CreateModelInvocationJobOutput = try aws.json.parseJsonObject(
        CreateModelInvocationJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
