const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const BatchInferenceJobConfig = @import("batch_inference_job_config.zig").BatchInferenceJobConfig;
const BatchInferenceJobMode = @import("batch_inference_job_mode.zig").BatchInferenceJobMode;
const BatchInferenceJobInput = @import("batch_inference_job_input.zig").BatchInferenceJobInput;
const BatchInferenceJobOutput = @import("batch_inference_job_output.zig").BatchInferenceJobOutput;
const Tag = @import("tag.zig").Tag;
const ThemeGenerationConfig = @import("theme_generation_config.zig").ThemeGenerationConfig;

pub const CreateBatchInferenceJobInput = struct {
    /// The configuration details of a batch inference job.
    batch_inference_job_config: ?BatchInferenceJobConfig = null,

    /// The mode of the batch inference job. To generate descriptive themes for
    /// groups of similar items, set the
    /// job mode to `THEME_GENERATION`. If you don't want to generate themes, use
    /// the default `BATCH_INFERENCE`.
    ///
    /// When you get batch recommendations with themes, you will incur additional
    /// costs. For more information, see [Amazon Personalize
    /// pricing](https://aws.amazon.com/personalize/pricing/).
    batch_inference_job_mode: ?BatchInferenceJobMode = null,

    /// The ARN of the filter to apply to the batch inference job. For more
    /// information on using
    /// filters, see
    /// [Filtering batch
    /// recommendations](https://docs.aws.amazon.com/personalize/latest/dg/filter-batch.html).
    filter_arn: ?[]const u8 = null,

    /// The Amazon S3 path that leads to the input file to base your recommendations
    /// on. The input
    /// material must be in JSON format.
    job_input: BatchInferenceJobInput,

    /// The name of the batch inference job to create.
    job_name: []const u8,

    /// The path to the Amazon S3 bucket where the job's output will be stored.
    job_output: BatchInferenceJobOutput,

    /// The number of recommendations to retrieve.
    num_results: ?i32 = null,

    /// The ARN of the Amazon Identity and Access Management role that has
    /// permissions to read and write to your input and output
    /// Amazon S3 buckets respectively.
    role_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the solution version that will be used to
    /// generate the
    /// batch inference recommendations.
    solution_version_arn: []const u8,

    /// A list of
    /// [tags](https://docs.aws.amazon.com/personalize/latest/dg/tagging-resources.html) to apply to the batch inference job.
    tags: ?[]const Tag = null,

    /// For theme generation jobs, specify the name of the column in your Items
    /// dataset that contains each item's name.
    theme_generation_config: ?ThemeGenerationConfig = null,

    pub const json_field_names = .{
        .batch_inference_job_config = "batchInferenceJobConfig",
        .batch_inference_job_mode = "batchInferenceJobMode",
        .filter_arn = "filterArn",
        .job_input = "jobInput",
        .job_name = "jobName",
        .job_output = "jobOutput",
        .num_results = "numResults",
        .role_arn = "roleArn",
        .solution_version_arn = "solutionVersionArn",
        .tags = "tags",
        .theme_generation_config = "themeGenerationConfig",
    };
};

pub const CreateBatchInferenceJobOutput = struct {
    /// The ARN of the batch inference job.
    batch_inference_job_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .batch_inference_job_arn = "batchInferenceJobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBatchInferenceJobInput, options: CallOptions) !CreateBatchInferenceJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "personalize");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBatchInferenceJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("personalize", "Personalize", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonPersonalize.CreateBatchInferenceJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBatchInferenceJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateBatchInferenceJobOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagKeysException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tag_keys_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
