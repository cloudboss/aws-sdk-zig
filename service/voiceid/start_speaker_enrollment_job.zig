const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EnrollmentConfig = @import("enrollment_config.zig").EnrollmentConfig;
const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const SpeakerEnrollmentJob = @import("speaker_enrollment_job.zig").SpeakerEnrollmentJob;

pub const StartSpeakerEnrollmentJobInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// The IAM role Amazon Resource Name (ARN) that grants Voice ID permissions to
    /// access
    /// customer's buckets to read the input manifest file and write the job output
    /// file. Refer
    /// to [Batch enrollment using
    /// audio data from prior
    /// calls](https://docs.aws.amazon.com/connect/latest/adminguide/voiceid-batch-enrollment.html) for the permissions needed in this role.
    data_access_role_arn: []const u8,

    /// The identifier of the domain that contains the speaker enrollment job and in
    /// which the
    /// speakers are enrolled.
    domain_id: []const u8,

    /// The enrollment config that contains details such as the action to take when
    /// a speaker
    /// is already enrolled in Voice ID or when a speaker is identified as a
    /// fraudster.
    enrollment_config: ?EnrollmentConfig = null,

    /// The input data config containing the S3 location for the input manifest file
    /// that
    /// contains the list of speaker enrollment requests.
    input_data_config: InputDataConfig,

    /// A name for your speaker enrollment job.
    job_name: ?[]const u8 = null,

    /// The output data config containing the S3 location where Voice ID writes the
    /// job
    /// output file; you must also include a KMS key ID to encrypt the
    /// file.
    output_data_config: OutputDataConfig,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .data_access_role_arn = "DataAccessRoleArn",
        .domain_id = "DomainId",
        .enrollment_config = "EnrollmentConfig",
        .input_data_config = "InputDataConfig",
        .job_name = "JobName",
        .output_data_config = "OutputDataConfig",
    };
};

pub const StartSpeakerEnrollmentJobOutput = struct {
    /// Details about the started speaker enrollment job.
    job: ?SpeakerEnrollmentJob = null,

    pub const json_field_names = .{
        .job = "Job",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSpeakerEnrollmentJobInput, options: Options) !StartSpeakerEnrollmentJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "voiceid");

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartSpeakerEnrollmentJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voiceid", "Voice ID", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "VoiceID.StartSpeakerEnrollmentJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartSpeakerEnrollmentJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartSpeakerEnrollmentJobOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
