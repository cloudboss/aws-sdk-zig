const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RecommendationJobInputConfig = @import("recommendation_job_input_config.zig").RecommendationJobInputConfig;
const RecommendationJobType = @import("recommendation_job_type.zig").RecommendationJobType;
const RecommendationJobOutputConfig = @import("recommendation_job_output_config.zig").RecommendationJobOutputConfig;
const RecommendationJobStoppingConditions = @import("recommendation_job_stopping_conditions.zig").RecommendationJobStoppingConditions;
const Tag = @import("tag.zig").Tag;

pub const CreateInferenceRecommendationsJobInput = struct {
    /// Provides information about the versioned model package Amazon Resource Name
    /// (ARN), the traffic pattern, and endpoint configurations.
    input_config: RecommendationJobInputConfig,

    /// Description of the recommendation job.
    job_description: ?[]const u8 = null,

    /// A name for the recommendation job. The name must be unique within the Amazon
    /// Web Services Region and within your Amazon Web Services account. The job
    /// name is passed down to the resources created by the recommendation job. The
    /// names of resources (such as the model, endpoint configuration, endpoint, and
    /// compilation) that are prefixed with the job name are truncated at 40
    /// characters.
    job_name: []const u8,

    /// Defines the type of recommendation job. Specify `Default` to initiate an
    /// instance recommendation and `Advanced` to initiate a load test. If left
    /// unspecified, Amazon SageMaker Inference Recommender will run an instance
    /// recommendation (`DEFAULT`) job.
    job_type: RecommendationJobType,

    /// Provides information about the output artifacts and the KMS key to use for
    /// Amazon S3 server-side encryption.
    output_config: ?RecommendationJobOutputConfig = null,

    /// The Amazon Resource Name (ARN) of an IAM role that enables Amazon SageMaker
    /// to perform tasks on your behalf.
    role_arn: []const u8,

    /// A set of conditions for stopping a recommendation job. If any of the
    /// conditions are met, the job is automatically stopped.
    stopping_conditions: ?RecommendationJobStoppingConditions = null,

    /// The metadata that you apply to Amazon Web Services resources to help you
    /// categorize and organize them. Each tag consists of a key and a value, both
    /// of which you define. For more information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the Amazon Web Services General Reference.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .input_config = "InputConfig",
        .job_description = "JobDescription",
        .job_name = "JobName",
        .job_type = "JobType",
        .output_config = "OutputConfig",
        .role_arn = "RoleArn",
        .stopping_conditions = "StoppingConditions",
        .tags = "Tags",
    };
};

pub const CreateInferenceRecommendationsJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the recommendation job.
    job_arn: []const u8,

    pub const json_field_names = .{
        .job_arn = "JobArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInferenceRecommendationsJobInput, options: Options) !CreateInferenceRecommendationsJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateInferenceRecommendationsJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.CreateInferenceRecommendationsJob");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateInferenceRecommendationsJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateInferenceRecommendationsJobOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
