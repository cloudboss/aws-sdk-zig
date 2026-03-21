const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const HumanTaskConfig = @import("human_task_config.zig").HumanTaskConfig;
const LabelingJobInputConfig = @import("labeling_job_input_config.zig").LabelingJobInputConfig;
const LabelCounters = @import("label_counters.zig").LabelCounters;
const LabelingJobAlgorithmsConfig = @import("labeling_job_algorithms_config.zig").LabelingJobAlgorithmsConfig;
const LabelingJobOutput = @import("labeling_job_output.zig").LabelingJobOutput;
const LabelingJobStatus = @import("labeling_job_status.zig").LabelingJobStatus;
const LabelingJobOutputConfig = @import("labeling_job_output_config.zig").LabelingJobOutputConfig;
const LabelingJobStoppingConditions = @import("labeling_job_stopping_conditions.zig").LabelingJobStoppingConditions;
const Tag = @import("tag.zig").Tag;

pub const DescribeLabelingJobInput = struct {
    /// The name of the labeling job to return information for.
    labeling_job_name: []const u8,

    pub const json_field_names = .{
        .labeling_job_name = "LabelingJobName",
    };
};

pub const DescribeLabelingJobOutput = struct {
    /// The date and time that the labeling job was created.
    creation_time: i64,

    /// If the job failed, the reason that it failed.
    failure_reason: ?[]const u8 = null,

    /// Configuration information required for human workers to complete a labeling
    /// task.
    human_task_config: ?HumanTaskConfig = null,

    /// Input configuration information for the labeling job, such as the Amazon S3
    /// location of the data objects and the location of the manifest file that
    /// describes the data objects.
    input_config: ?LabelingJobInputConfig = null,

    /// A unique identifier for work done as part of a labeling job.
    job_reference_code: []const u8,

    /// The attribute used as the label in the output manifest file.
    label_attribute_name: ?[]const u8 = null,

    /// The S3 location of the JSON file that defines the categories used to label
    /// data objects. Please note the following label-category limits:
    ///
    /// * Semantic segmentation labeling jobs using automated labeling: 20 labels
    /// * Box bounding labeling jobs (all): 10 labels
    ///
    /// The file is a JSON structure in the following format:
    ///
    /// `{`
    ///
    /// ` "document-version": "2018-11-28"`
    ///
    /// ` "labels": [`
    ///
    /// ` {`
    ///
    /// ` "label": "*label 1*"`
    ///
    /// ` },`
    ///
    /// ` {`
    ///
    /// ` "label": "*label 2*"`
    ///
    /// ` },`
    ///
    /// ` ...`
    ///
    /// ` {`
    ///
    /// ` "label": "*label n*"`
    ///
    /// ` }`
    ///
    /// ` ]`
    ///
    /// `}`
    label_category_config_s3_uri: ?[]const u8 = null,

    /// Provides a breakdown of the number of data objects labeled by humans, the
    /// number of objects labeled by machine, the number of objects than couldn't be
    /// labeled, and the total number of objects labeled.
    label_counters: ?LabelCounters = null,

    /// Configuration information for automated data labeling.
    labeling_job_algorithms_config: ?LabelingJobAlgorithmsConfig = null,

    /// The Amazon Resource Name (ARN) of the labeling job.
    labeling_job_arn: []const u8,

    /// The name assigned to the labeling job when it was created.
    labeling_job_name: []const u8,

    /// The location of the output produced by the labeling job.
    labeling_job_output: ?LabelingJobOutput = null,

    /// The processing status of the labeling job.
    labeling_job_status: LabelingJobStatus,

    /// The date and time that the labeling job was last updated.
    last_modified_time: i64,

    /// The location of the job's output data and the Amazon Web Services Key
    /// Management Service key ID for the key used to encrypt the output data, if
    /// any.
    output_config: ?LabelingJobOutputConfig = null,

    /// The Amazon Resource Name (ARN) that SageMaker assumes to perform tasks on
    /// your behalf during data labeling.
    role_arn: []const u8,

    /// A set of conditions for stopping a labeling job. If any of the conditions
    /// are met, the job is automatically stopped.
    stopping_conditions: ?LabelingJobStoppingConditions = null,

    /// An array of key-value pairs. You can use tags to categorize your Amazon Web
    /// Services resources in different ways, for example, by purpose, owner, or
    /// environment. For more information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .human_task_config = "HumanTaskConfig",
        .input_config = "InputConfig",
        .job_reference_code = "JobReferenceCode",
        .label_attribute_name = "LabelAttributeName",
        .label_category_config_s3_uri = "LabelCategoryConfigS3Uri",
        .label_counters = "LabelCounters",
        .labeling_job_algorithms_config = "LabelingJobAlgorithmsConfig",
        .labeling_job_arn = "LabelingJobArn",
        .labeling_job_name = "LabelingJobName",
        .labeling_job_output = "LabelingJobOutput",
        .labeling_job_status = "LabelingJobStatus",
        .last_modified_time = "LastModifiedTime",
        .output_config = "OutputConfig",
        .role_arn = "RoleArn",
        .stopping_conditions = "StoppingConditions",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLabelingJobInput, options: CallOptions) !DescribeLabelingJobOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLabelingJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeLabelingJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLabelingJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeLabelingJobOutput, body, allocator);
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
