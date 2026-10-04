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
const TimeoutConfig = @import("timeout_config.zig").TimeoutConfig;

pub const DescribeJobTemplateInput = struct {
    /// The unique identifier of the job template.
    job_template_id: []const u8,

    pub const json_field_names = .{
        .job_template_id = "jobTemplateId",
    };
};

pub const DescribeJobTemplateOutput = struct {
    abort_config: ?AbortConfig = null,

    /// The time, in seconds since the epoch, when the job template was created.
    created_at: ?i64 = null,

    /// A description of the job template.
    description: ?[]const u8 = null,

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

    /// The job document.
    document: ?[]const u8 = null,

    /// An S3 link to the job document.
    document_source: ?[]const u8 = null,

    /// The configuration that determines how many retries are allowed for each
    /// failure type
    /// for a job.
    job_executions_retry_config: ?JobExecutionsRetryConfig = null,

    job_executions_rollout_config: ?JobExecutionsRolloutConfig = null,

    /// The ARN of the job template.
    job_template_arn: ?[]const u8 = null,

    /// The unique identifier of the job template.
    job_template_id: ?[]const u8 = null,

    /// Allows you to configure an optional maintenance window for the rollout of a
    /// job
    /// document to all devices in the target group for a job.
    maintenance_windows: ?[]const MaintenanceWindow = null,

    presigned_url_config: ?PresignedUrlConfig = null,

    timeout_config: ?TimeoutConfig = null,

    pub const json_field_names = .{
        .abort_config = "abortConfig",
        .created_at = "createdAt",
        .description = "description",
        .destination_package_versions = "destinationPackageVersions",
        .document = "document",
        .document_source = "documentSource",
        .job_executions_retry_config = "jobExecutionsRetryConfig",
        .job_executions_rollout_config = "jobExecutionsRolloutConfig",
        .job_template_arn = "jobTemplateArn",
        .job_template_id = "jobTemplateId",
        .maintenance_windows = "maintenanceWindows",
        .presigned_url_config = "presignedUrlConfig",
        .timeout_config = "timeoutConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeJobTemplateInput, options: CallOptions) !DescribeJobTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeJobTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/job-templates/");
    try path_buf.appendSlice(allocator, input.job_template_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeJobTemplateOutput {
    var result: DescribeJobTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeJobTemplateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
