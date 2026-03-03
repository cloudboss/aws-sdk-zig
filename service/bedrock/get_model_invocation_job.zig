const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ModelInvocationJobInputDataConfig = @import("model_invocation_job_input_data_config.zig").ModelInvocationJobInputDataConfig;
const ModelInvocationJobOutputDataConfig = @import("model_invocation_job_output_data_config.zig").ModelInvocationJobOutputDataConfig;
const ModelInvocationJobStatus = @import("model_invocation_job_status.zig").ModelInvocationJobStatus;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

pub const GetModelInvocationJobInput = struct {
    /// The Amazon Resource Name (ARN) of the batch inference job.
    job_identifier: []const u8,

    pub const json_field_names = .{
        .job_identifier = "jobIdentifier",
    };
};

pub const GetModelInvocationJobOutput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_request_token: ?[]const u8 = null,

    /// The time at which the batch inference job ended.
    end_time: ?i64 = null,

    /// Details about the location of the input to the batch inference job.
    input_data_config: ?ModelInvocationJobInputDataConfig = null,

    /// The Amazon Resource Name (ARN) of the batch inference job.
    job_arn: []const u8,

    /// The time at which the batch inference job times or timed out.
    job_expiration_time: ?i64 = null,

    /// The name of the batch inference job.
    job_name: ?[]const u8 = null,

    /// The time at which the batch inference job was last modified.
    last_modified_time: ?i64 = null,

    /// If the batch inference job failed, this field contains a message describing
    /// why the job failed.
    message: ?[]const u8 = null,

    /// The unique identifier of the foundation model used for model inference.
    model_id: []const u8,

    /// Details about the location of the output of the batch inference job.
    output_data_config: ?ModelInvocationJobOutputDataConfig = null,

    /// The Amazon Resource Name (ARN) of the service role with permissions to carry
    /// out and manage batch inference. You can use the console to create a default
    /// service role or follow the steps at [Create a service role for batch
    /// inference](https://docs.aws.amazon.com/bedrock/latest/userguide/batch-iam-sr.html).
    role_arn: []const u8,

    /// The status of the batch inference job.
    ///
    /// The following statuses are possible:
    ///
    /// * Submitted – This job has been submitted to a queue for validation.
    /// * Validating – This job is being validated for the requirements described in
    ///   [Format and upload your batch inference
    ///   data](https://docs.aws.amazon.com/bedrock/latest/userguide/batch-inference-data.html). The criteria include the following:
    ///
    /// * Your IAM service role has access to the Amazon S3 buckets containing your
    ///   files.
    /// * Your files are .jsonl files and each individual record is a JSON object in
    ///   the correct format. Note that validation doesn't check if the `modelInput`
    ///   value matches the request body for the model.
    /// * Your files fulfill the requirements for file size and number of records.
    ///   For more information, see [Quotas for Amazon
    ///   Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/quotas.html).
    ///
    /// * Scheduled – This job has been validated and is now in a queue. The job
    ///   will automatically start when it reaches its turn.
    /// * Expired – This job timed out because it was scheduled but didn't begin
    ///   before the set timeout duration. Submit a new job request.
    /// * InProgress – This job has begun. You can start viewing the results in the
    ///   output S3 location.
    /// * Completed – This job has successfully completed. View the output files in
    ///   the output S3 location.
    /// * PartiallyCompleted – This job has partially completed. Not all of your
    ///   records could be processed in time. View the output files in the output S3
    ///   location.
    /// * Failed – This job has failed. Check the failure message for any further
    ///   details. For further assistance, reach out to the [Amazon Web Services
    ///   Support Center](https://console.aws.amazon.com/support/home/).
    /// * Stopped – This job was stopped by a user.
    /// * Stopping – This job is being stopped by a user.
    status: ?ModelInvocationJobStatus = null,

    /// The time at which the batch inference job was submitted.
    submit_time: i64,

    /// The number of hours after which batch inference job was set to time out.
    timeout_duration_in_hours: ?i32 = null,

    /// The configuration of the Virtual Private Cloud (VPC) for the data in the
    /// batch inference job. For more information, see [Protect batch inference jobs
    /// using a
    /// VPC](https://docs.aws.amazon.com/bedrock/latest/userguide/batch-vpc).
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .end_time = "endTime",
        .input_data_config = "inputDataConfig",
        .job_arn = "jobArn",
        .job_expiration_time = "jobExpirationTime",
        .job_name = "jobName",
        .last_modified_time = "lastModifiedTime",
        .message = "message",
        .model_id = "modelId",
        .output_data_config = "outputDataConfig",
        .role_arn = "roleArn",
        .status = "status",
        .submit_time = "submitTime",
        .timeout_duration_in_hours = "timeoutDurationInHours",
        .vpc_config = "vpcConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetModelInvocationJobInput, options: CallOptions) !GetModelInvocationJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrock");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetModelInvocationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/model-invocation-job/");
    try path_buf.appendSlice(allocator, input.job_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetModelInvocationJobOutput {
    var result: GetModelInvocationJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetModelInvocationJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
