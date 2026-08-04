const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const LanguageCode = @import("language_code.zig").LanguageCode;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const Tag = @import("tag.zig").Tag;
const VpcConfig = @import("vpc_config.zig").VpcConfig;
const JobStatus = @import("job_status.zig").JobStatus;

pub const StartTargetedSentimentDetectionJobInput = struct {
    /// A unique identifier for the request. If you don't set the client request
    /// token, Amazon
    /// Comprehend generates one.
    client_request_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that
    /// grants Amazon Comprehend read access to your input data. For more
    /// information, see [Role-based
    /// permissions](https://docs.aws.amazon.com/comprehend/latest/dg/security_iam_id-based-policy-examples.html#auth-role-permissions).
    data_access_role_arn: []const u8,

    input_data_config: InputDataConfig,

    /// The identifier of the job.
    job_name: ?[]const u8 = null,

    /// The language of the input documents. Currently, English is the only
    /// supported language.
    language_code: LanguageCode,

    /// Specifies where to send the output files.
    output_data_config: OutputDataConfig,

    /// Tags to associate with the targeted sentiment detection job. A tag is a
    /// key-value pair that
    /// adds metadata to a resource used by Amazon Comprehend. For example, a tag
    /// with "Sales" as the
    /// key might be added to a resource to indicate its use by the sales
    /// department.
    tags: ?[]const Tag = null,

    /// ID for the KMS key that Amazon Comprehend uses to encrypt
    /// data on the storage volume attached to the ML compute instance(s) that
    /// process the analysis
    /// job. The VolumeKmsKeyId can be either of the following formats:
    ///
    /// * KMS Key ID: `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    ///
    /// * Amazon Resource Name (ARN) of a KMS Key:
    /// `"arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"`
    volume_kms_key_id: ?[]const u8 = null,

    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .data_access_role_arn = "DataAccessRoleArn",
        .input_data_config = "InputDataConfig",
        .job_name = "JobName",
        .language_code = "LanguageCode",
        .output_data_config = "OutputDataConfig",
        .tags = "Tags",
        .volume_kms_key_id = "VolumeKmsKeyId",
        .vpc_config = "VpcConfig",
    };
};

pub const StartTargetedSentimentDetectionJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the targeted sentiment detection job. It
    /// is a unique, fully
    /// qualified identifier for the job. It includes the Amazon Web Services
    /// account, Amazon Web Services Region, and the job ID. The
    /// format of the ARN is as follows:
    ///
    /// `arn::comprehend:::targeted-sentiment-detection-job/`
    ///
    /// The following is an example job ARN:
    ///
    /// `arn:aws:comprehend:us-west-2:111122223333:targeted-sentiment-detection-job/1234abcd12ab34cd56ef1234567890ab`
    job_arn: ?[]const u8 = null,

    /// The identifier generated for the job. To get the status of a job, use this
    /// identifier with
    /// the `DescribeTargetedSentimentDetectionJob` operation.
    job_id: ?[]const u8 = null,

    /// The status of the job.
    ///
    /// * SUBMITTED - The job has been received and is queued for processing.
    ///
    /// * IN_PROGRESS - Amazon Comprehend is processing the job.
    ///
    /// * COMPLETED - The job was successfully completed and the output is
    ///   available.
    ///
    /// * FAILED - The job did not complete. To get details, use the
    /// `DescribeTargetedSentimentDetectionJob` operation.
    job_status: ?JobStatus = null,

    pub const json_field_names = .{
        .job_arn = "JobArn",
        .job_id = "JobId",
        .job_status = "JobStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartTargetedSentimentDetectionJobInput, options: CallOptions) !StartTargetedSentimentDetectionJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "comprehend", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: StartTargetedSentimentDetectionJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("comprehend", "Comprehend", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.StartTargetedSentimentDetectionJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartTargetedSentimentDetectionJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartTargetedSentimentDetectionJobOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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

    if (std.mem.eql(u8, error_code, "BatchSizeLimitExceededException")) {
        const parsed_error: ?errors.BatchSizeLimitExceededException = aws.json.parseJsonObject(errors.BatchSizeLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .batch_size_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        const parsed_error: ?errors.ConcurrentModificationException = aws.json.parseJsonObject(errors.ConcurrentModificationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        const parsed_error: ?errors.InternalServerException = aws.json.parseJsonObject(errors.InternalServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterException")) {
        const parsed_error: ?errors.InvalidFilterException = aws.json.parseJsonObject(errors.InvalidFilterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_filter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        const parsed_error: ?errors.InvalidRequestException = aws.json.parseJsonObject(errors.InvalidRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "JobNotFoundException")) {
        const parsed_error: ?errors.JobNotFoundException = aws.json.parseJsonObject(errors.JobNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .job_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KmsKeyValidationException")) {
        const parsed_error: ?errors.KmsKeyValidationException = aws.json.parseJsonObject(errors.KmsKeyValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_key_validation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        const parsed_error: ?errors.ResourceInUseException = aws.json.parseJsonObject(errors.ResourceInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        const parsed_error: ?errors.ResourceLimitExceededException = aws.json.parseJsonObject(errors.ResourceLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceUnavailableException")) {
        const parsed_error: ?errors.ResourceUnavailableException = aws.json.parseJsonObject(errors.ResourceUnavailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_unavailable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TextSizeLimitExceededException")) {
        const parsed_error: ?errors.TextSizeLimitExceededException = aws.json.parseJsonObject(errors.TextSizeLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .text_size_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        const parsed_error: ?errors.TooManyRequestsException = aws.json.parseJsonObject(errors.TooManyRequestsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_requests_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTagKeysException")) {
        const parsed_error: ?errors.TooManyTagKeysException = aws.json.parseJsonObject(errors.TooManyTagKeysException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tag_keys_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        const parsed_error: ?errors.TooManyTagsException = aws.json.parseJsonObject(errors.TooManyTagsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedLanguageException")) {
        const parsed_error: ?errors.UnsupportedLanguageException = aws.json.parseJsonObject(errors.UnsupportedLanguageException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_language_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
