const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AbortConfig = @import("abort_config.zig").AbortConfig;
const JobExecutionsRetryConfig = @import("job_executions_retry_config.zig").JobExecutionsRetryConfig;
const JobExecutionsRolloutConfig = @import("job_executions_rollout_config.zig").JobExecutionsRolloutConfig;
const MaintenanceWindow = @import("maintenance_window.zig").MaintenanceWindow;
const PresignedUrlConfig = @import("presigned_url_config.zig").PresignedUrlConfig;
const Tag = @import("tag.zig").Tag;
const TimeoutConfig = @import("timeout_config.zig").TimeoutConfig;

pub const CreateJobTemplateInput = struct {
    abort_config: ?AbortConfig = null,

    /// A description of the job document.
    description: []const u8,

    /// The package version Amazon Resource Names (ARNs) that are installed on the
    /// device when the job
    /// successfully completes. The package version must be in either the Published
    /// or
    /// Deprecated state when the job deploys. For more information, see [Package
    /// version
    /// lifecycle](https://docs.aws.amazon.com/iot/latest/developerguide/preparing-to-use-software-package-catalog.html#package-version-lifecycle).
    ///
    /// **Note:**The following Length Constraints relates to a
    /// single ARN. Up to 25 package version ARNs are allowed.
    destination_package_versions: ?[]const []const u8 = null,

    /// The job document. Required if you don't specify a value for
    /// `documentSource`.
    document: ?[]const u8 = null,

    /// An S3 link, or S3 object URL, to the job document. The link is an Amazon S3
    /// object URL
    /// and is required if you don't specify a value for `document`.
    ///
    /// For example, `--document-source
    /// https://s3.*region-code*.amazonaws.com/example-firmware/device-firmware.1.0`
    ///
    /// For more information, see [Methods for accessing a
    /// bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-bucket-intro.html).
    document_source: ?[]const u8 = null,

    /// The ARN of the job to use as the basis for the job template.
    job_arn: ?[]const u8 = null,

    /// Allows you to create the criteria to retry a job.
    job_executions_retry_config: ?JobExecutionsRetryConfig = null,

    job_executions_rollout_config: ?JobExecutionsRolloutConfig = null,

    /// A unique identifier for the job template. We recommend using a UUID.
    /// Alpha-numeric
    /// characters, "-", and "_" are valid for use here.
    job_template_id: []const u8,

    /// Allows you to configure an optional maintenance window for the rollout of a
    /// job
    /// document to all devices in the target group for a job.
    maintenance_windows: ?[]const MaintenanceWindow = null,

    presigned_url_config: ?PresignedUrlConfig = null,

    /// Metadata that can be used to manage the job template.
    tags: ?[]const Tag = null,

    timeout_config: ?TimeoutConfig = null,

    pub const json_field_names = .{
        .abort_config = "abortConfig",
        .description = "description",
        .destination_package_versions = "destinationPackageVersions",
        .document = "document",
        .document_source = "documentSource",
        .job_arn = "jobArn",
        .job_executions_retry_config = "jobExecutionsRetryConfig",
        .job_executions_rollout_config = "jobExecutionsRolloutConfig",
        .job_template_id = "jobTemplateId",
        .maintenance_windows = "maintenanceWindows",
        .presigned_url_config = "presignedUrlConfig",
        .tags = "tags",
        .timeout_config = "timeoutConfig",
    };
};

pub const CreateJobTemplateOutput = struct {
    /// The ARN of the job template.
    job_template_arn: ?[]const u8 = null,

    /// The unique identifier of the job template.
    job_template_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_template_arn = "jobTemplateArn",
        .job_template_id = "jobTemplateId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateJobTemplateInput, options: CallOptions) !CreateJobTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateJobTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/job-templates/");
    try path_buf.appendSlice(allocator, input.job_template_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.abort_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"abortConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"description\":");
    try aws.json.writeValue(@TypeOf(input.description), input.description, allocator, &body_buf);
    has_prev = true;
    if (input.destination_package_versions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"destinationPackageVersions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.document) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"document\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.document_source) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"documentSource\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.job_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.job_executions_retry_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobExecutionsRetryConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.job_executions_rollout_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobExecutionsRolloutConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maintenance_windows) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maintenanceWindows\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.presigned_url_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"presignedUrlConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.timeout_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"timeoutConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateJobTemplateOutput {
    const result: CreateJobTemplateOutput = try aws.json.parseJsonObject(
        CreateJobTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
