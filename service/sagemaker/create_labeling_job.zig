const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const HumanTaskConfig = @import("human_task_config.zig").HumanTaskConfig;
const LabelingJobInputConfig = @import("labeling_job_input_config.zig").LabelingJobInputConfig;
const LabelingJobAlgorithmsConfig = @import("labeling_job_algorithms_config.zig").LabelingJobAlgorithmsConfig;
const LabelingJobOutputConfig = @import("labeling_job_output_config.zig").LabelingJobOutputConfig;
const LabelingJobStoppingConditions = @import("labeling_job_stopping_conditions.zig").LabelingJobStoppingConditions;
const Tag = @import("tag.zig").Tag;

pub const CreateLabelingJobInput = struct {
    /// Configures the labeling task and how it is presented to workers; including,
    /// but not limited to price, keywords, and batch size (task count).
    human_task_config: HumanTaskConfig,

    /// Input data for the labeling job, such as the Amazon S3 location of the data
    /// objects and the location of the manifest file that describes the data
    /// objects.
    ///
    /// You must specify at least one of the following: `S3DataSource` or
    /// `SnsDataSource`.
    ///
    /// * Use `SnsDataSource` to specify an SNS input topic for a streaming labeling
    ///   job. If you do not specify and SNS input topic ARN, Ground Truth will
    ///   create a one-time labeling job that stops after all data objects in the
    ///   input manifest file have been labeled.
    /// * Use `S3DataSource` to specify an input manifest file for both streaming
    ///   and one-time labeling jobs. Adding an `S3DataSource` is optional if you
    ///   use `SnsDataSource` to create a streaming labeling job.
    ///
    /// If you use the Amazon Mechanical Turk workforce, your input data should not
    /// include confidential information, personal information or protected health
    /// information. Use `ContentClassifiers` to specify that your data is free of
    /// personally identifiable information and adult content.
    input_config: LabelingJobInputConfig,

    /// The attribute name to use for the label in the output manifest file. This is
    /// the key for the key/value pair formed with the label that a worker assigns
    /// to the object. The `LabelAttributeName` must meet the following
    /// requirements.
    ///
    /// * The name can't end with "-metadata".
    /// * If you are using one of the [built-in task
    ///   types](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-task-types.html) or one of the following, the attribute name *must* end with "-ref".
    ///
    /// * Image semantic segmentation (`SemanticSegmentation)` and adjustment
    ///   (`AdjustmentSemanticSegmentation`) labeling jobs for this task type. One
    ///   exception is that verification (`VerificationSemanticSegmentation`) *must
    ///   not* end with -"ref".
    /// * Video frame object detection (`VideoObjectDetection`), and adjustment and
    ///   verification (`AdjustmentVideoObjectDetection`) labeling jobs for this
    ///   task type.
    /// * Video frame object tracking (`VideoObjectTracking`), and adjustment and
    ///   verification (`AdjustmentVideoObjectTracking`) labeling jobs for this task
    ///   type.
    /// * 3D point cloud semantic segmentation (`3DPointCloudSemanticSegmentation`),
    ///   and adjustment and verification
    ///   (`Adjustment3DPointCloudSemanticSegmentation`) labeling jobs for this task
    ///   type.
    /// * 3D point cloud object tracking (`3DPointCloudObjectTracking`), and
    ///   adjustment and verification (`Adjustment3DPointCloudObjectTracking`)
    ///   labeling jobs for this task type.
    ///
    /// If you are creating an adjustment or verification labeling job, you must use
    /// a *different* `LabelAttributeName` than the one used in the original
    /// labeling job. The original labeling job is the Ground Truth labeling job
    /// that produced the labels that you want verified or adjusted. To learn more
    /// about adjustment and verification labeling jobs, see [Verify and Adjust
    /// Labels](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-verification-data.html).
    label_attribute_name: []const u8,

    /// The S3 URI of the file, referred to as a *label category configuration
    /// file*, that defines the categories used to label the data objects.
    ///
    /// For 3D point cloud and video frame task types, you can add label category
    /// attributes and frame attributes to your label category configuration file.
    /// To learn how, see [Create a Labeling Category Configuration File for 3D
    /// Point Cloud Labeling
    /// Jobs](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-point-cloud-label-category-config.html).
    ///
    /// For named entity recognition jobs, in addition to `"labels"`, you must
    /// provide worker instructions in the label category configuration file using
    /// the `"instructions"` parameter: `"instructions":
    /// {"shortInstruction":"<h1>Add header</h1><p>Add Instructions</p>",
    /// "fullInstruction":"<p>Add additional instructions.</p>"}`. For details and
    /// an example, see [Create a Named Entity Recognition Labeling Job (API)
    /// ](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-named-entity-recg.html#sms-creating-ner-api).
    ///
    /// For all other [built-in task
    /// types](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-task-types.html)
    /// and [custom
    /// tasks](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-custom-templates.html), your label category configuration file must be a JSON file in the following format. Identify the labels you want to use by replacing `label_1`, `label_2`,`...`,`label_n` with your label categories.
    ///
    /// `{ `
    ///
    /// `"document-version": "2018-11-28",`
    ///
    /// `"labels": [{"label": "label_1"},{"label": "label_2"},...{"label":
    /// "label_n"}]`
    ///
    /// `}`
    ///
    /// Note the following about the label category configuration file:
    ///
    /// * For image classification and text classification (single and multi-label)
    ///   you must specify at least two label categories. For all other task types,
    ///   the minimum number of label categories required is one.
    /// * Each label category must be unique, you cannot specify duplicate label
    ///   categories.
    /// * If you create a 3D point cloud or video frame adjustment or verification
    ///   labeling job, you must include `auditLabelAttributeName` in the label
    ///   category configuration. Use this parameter to enter the [
    ///   `LabelAttributeName`
    ///   ](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateLabelingJob.html#sagemaker-CreateLabelingJob-request-LabelAttributeName) of the labeling job you want to adjust or verify annotations of.
    label_category_config_s3_uri: ?[]const u8 = null,

    /// Configures the information required to perform automated data labeling.
    labeling_job_algorithms_config: ?LabelingJobAlgorithmsConfig = null,

    /// The name of the labeling job. This name is used to identify the job in a
    /// list of labeling jobs. Labeling job names must be unique within an Amazon
    /// Web Services account and region. `LabelingJobName` is not case sensitive.
    /// For example, Example-job and example-job are considered the same labeling
    /// job name by Ground Truth.
    labeling_job_name: []const u8,

    /// The location of the output data and the Amazon Web Services Key Management
    /// Service key ID for the key used to encrypt the output data, if any.
    output_config: LabelingJobOutputConfig,

    /// The Amazon Resource Number (ARN) that Amazon SageMaker assumes to perform
    /// tasks on your behalf during data labeling. You must grant this role the
    /// necessary permissions so that Amazon SageMaker can successfully complete
    /// data labeling.
    role_arn: []const u8,

    /// A set of conditions for stopping the labeling job. If any of the conditions
    /// are met, the job is automatically stopped. You can use these conditions to
    /// control the cost of data labeling.
    stopping_conditions: ?LabelingJobStoppingConditions = null,

    /// An array of key/value pairs. For more information, see [Using Cost
    /// Allocation
    /// Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html#allocation-what) in the *Amazon Web Services Billing and Cost Management User Guide*.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .human_task_config = "HumanTaskConfig",
        .input_config = "InputConfig",
        .label_attribute_name = "LabelAttributeName",
        .label_category_config_s3_uri = "LabelCategoryConfigS3Uri",
        .labeling_job_algorithms_config = "LabelingJobAlgorithmsConfig",
        .labeling_job_name = "LabelingJobName",
        .output_config = "OutputConfig",
        .role_arn = "RoleArn",
        .stopping_conditions = "StoppingConditions",
        .tags = "Tags",
    };
};

pub const CreateLabelingJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the labeling job. You use this ARN to
    /// identify the labeling job.
    labeling_job_arn: []const u8,

    pub const json_field_names = .{
        .labeling_job_arn = "LabelingJobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLabelingJobInput, options: CallOptions) !CreateLabelingJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLabelingJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateLabelingJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLabelingJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateLabelingJobOutput, body, allocator);
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
