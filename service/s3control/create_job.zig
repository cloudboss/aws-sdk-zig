const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const JobManifest = @import("job_manifest.zig").JobManifest;
const JobManifestGenerator = @import("job_manifest_generator.zig").JobManifestGenerator;
const JobOperation = @import("job_operation.zig").JobOperation;
const JobReport = @import("job_report.zig").JobReport;
const S3Tag = @import("s3_tag.zig").S3Tag;
const serde = @import("serde.zig");

pub const CreateJobInput = struct {
    /// The Amazon Web Services account ID that creates the job.
    account_id: []const u8,

    /// An idempotency token to ensure that you don't accidentally submit the same
    /// request
    /// twice. You can use any string up to the maximum length.
    client_request_token: []const u8,

    /// Indicates whether confirmation is required before Amazon S3 runs the job.
    /// Confirmation is
    /// only required for jobs created through the Amazon S3 console.
    confirmation_required: ?bool = null,

    /// A description for this job. You can use any string within the permitted
    /// length.
    /// Descriptions don't need to be unique and can be used for multiple jobs.
    description: ?[]const u8 = null,

    /// Configuration parameters for the manifest.
    manifest: ?JobManifest = null,

    /// The attribute container for the ManifestGenerator details. Jobs must be
    /// created with
    /// either a manifest file or a ManifestGenerator, but not both.
    manifest_generator: ?JobManifestGenerator = null,

    /// The action that you want this job to perform on every object listed in the
    /// manifest. For
    /// more information about the available actions, see
    /// [Operations](https://docs.aws.amazon.com/AmazonS3/latest/dev/batch-ops-operations.html) in the
    /// *Amazon S3 User Guide*.
    operation: JobOperation,

    /// The numerical priority for this job. Higher numbers indicate higher
    /// priority.
    priority: ?i32 = null,

    /// Configuration parameters for the optional job-completion report.
    report: JobReport,

    /// The Amazon Resource Name (ARN) for the Identity and Access Management (IAM)
    /// role that Batch Operations will
    /// use to run this job's action on every object in the manifest.
    role_arn: []const u8,

    /// A set of tags to associate with the S3 Batch Operations job. This is an
    /// optional parameter.
    tags: ?[]const S3Tag = null,
};

pub const CreateJobOutput = struct {
    /// The ID for this job. Amazon S3 generates this ID automatically and returns
    /// it after a
    /// successful `Create Job` request.
    job_id: ?[]const u8 = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateJobInput, options: Options) !CreateJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "s3control");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3control", "S3 Control", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v20180820/jobs";

    var body_buf: std.ArrayList(u8) = .{};
    try body_buf.appendSlice(alloc, "<CreateJobRequest>");
    try body_buf.appendSlice(alloc, "<ClientRequestToken>");
    try aws.xml.appendXmlEscaped(alloc, &body_buf, input.client_request_token);
    try body_buf.appendSlice(alloc, "</ClientRequestToken>");
    if (input.confirmation_required) |v| {
        try body_buf.appendSlice(alloc, "<ConfirmationRequired>");
        try body_buf.appendSlice(alloc, if (v) "true" else "false");
        try body_buf.appendSlice(alloc, "</ConfirmationRequired>");
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "<Description>");
        try aws.xml.appendXmlEscaped(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "</Description>");
    }
    if (input.manifest) |v| {
        try body_buf.appendSlice(alloc, "<Manifest>");
        try serde.serializeJobManifest(alloc, &body_buf, v);
        try body_buf.appendSlice(alloc, "</Manifest>");
    }
    try body_buf.appendSlice(alloc, "<Operation>");
    try serde.serializeJobOperation(alloc, &body_buf, input.operation);
    try body_buf.appendSlice(alloc, "</Operation>");
    try body_buf.appendSlice(alloc, "<Priority>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{input.priority}) catch "";
        try body_buf.appendSlice(alloc, num_str);
    }
    try body_buf.appendSlice(alloc, "</Priority>");
    try body_buf.appendSlice(alloc, "<Report>");
    try serde.serializeJobReport(alloc, &body_buf, input.report);
    try body_buf.appendSlice(alloc, "</Report>");
    try body_buf.appendSlice(alloc, "<RoleArn>");
    try aws.xml.appendXmlEscaped(alloc, &body_buf, input.role_arn);
    try body_buf.appendSlice(alloc, "</RoleArn>");
    if (input.tags) |v| {
        try body_buf.appendSlice(alloc, "<Tags>");
        try serde.serializeS3TagSet(alloc, &body_buf, v, "member");
        try body_buf.appendSlice(alloc, "</Tags>");
    }
    try body_buf.appendSlice(alloc, "</CreateJobRequest>");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/xml");
    try request.headers.put(alloc, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateJobOutput {
    var result: CreateJobOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "JobId")) {
                    result.job_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .bucket_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyOwnedByYou")) {
        return .{ .arena = arena, .kind = .{ .bucket_already_owned_by_you = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotencyException")) {
        return .{ .arena = arena, .kind = .{ .idempotency_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "JobStatusException")) {
        return .{ .arena = arena, .kind = .{ .job_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchPublicAccessBlockConfiguration")) {
        return .{ .arena = arena, .kind = .{ .no_such_public_access_block_configuration = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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
