const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdvancedPromptOptimizationInputConfig = @import("advanced_prompt_optimization_input_config.zig").AdvancedPromptOptimizationInputConfig;
const ModelConfiguration = @import("model_configuration.zig").ModelConfiguration;
const AdvancedPromptOptimizationOutputConfig = @import("advanced_prompt_optimization_output_config.zig").AdvancedPromptOptimizationOutputConfig;
const Tag = @import("tag.zig").Tag;

pub const CreateAdvancedPromptOptimizationJobInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request but does not return an error.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS key used for encrypting the output
    /// data. If not specified, the output is encrypted with an Amazon-owned KMS
    /// key.
    encryption_key_arn: ?[]const u8 = null,

    /// Specifies the S3 location of your JSONL input file containing prompt
    /// templates and evaluation samples.
    input_config: AdvancedPromptOptimizationInputConfig,

    /// A description of the advanced prompt optimization job.
    job_description: ?[]const u8 = null,

    /// A name for the advanced prompt optimization job.
    job_name: []const u8,

    /// A list of model configurations specifying the target models for prompt
    /// optimization. You can specify up to 5 models.
    model_configurations: []const ModelConfiguration,

    /// Specifies the S3 location where optimization results will be stored.
    output_config: AdvancedPromptOptimizationOutputConfig,

    /// Tags to associate with the advanced prompt optimization job.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .encryption_key_arn = "encryptionKeyArn",
        .input_config = "inputConfig",
        .job_description = "jobDescription",
        .job_name = "jobName",
        .model_configurations = "modelConfigurations",
        .output_config = "outputConfig",
        .tags = "tags",
    };
};

pub const CreateAdvancedPromptOptimizationJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the created advanced prompt optimization
    /// job.
    job_arn: []const u8,

    pub const json_field_names = .{
        .job_arn = "jobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAdvancedPromptOptimizationJobInput, options: CallOptions) !CreateAdvancedPromptOptimizationJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAdvancedPromptOptimizationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/advanced-prompt-optimization-jobs";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.encryption_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"encryptionKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"inputConfig\":");
    try aws.json.writeValue(@TypeOf(input.input_config), input.input_config, allocator, &body_buf);
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"modelConfigurations\":");
    try aws.json.writeValue(@TypeOf(input.model_configurations), input.model_configurations, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"outputConfig\":");
    try aws.json.writeValue(@TypeOf(input.output_config), input.output_config, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAdvancedPromptOptimizationJobOutput {
    const result: CreateAdvancedPromptOptimizationJobOutput = try aws.json.parseJsonObject(
        CreateAdvancedPromptOptimizationJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
