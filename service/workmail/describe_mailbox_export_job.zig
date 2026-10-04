const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MailboxExportJobState = @import("mailbox_export_job_state.zig").MailboxExportJobState;

pub const DescribeMailboxExportJobInput = struct {
    /// The mailbox export job ID.
    job_id: []const u8,

    /// The organization ID.
    organization_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
        .organization_id = "OrganizationId",
    };
};

pub const DescribeMailboxExportJobOutput = struct {
    /// The mailbox export job description.
    description: ?[]const u8 = null,

    /// The mailbox export job end timestamp.
    end_time: ?i64 = null,

    /// The identifier of the user or resource associated with the mailbox.
    entity_id: ?[]const u8 = null,

    /// Error information for failed mailbox export jobs.
    error_info: ?[]const u8 = null,

    /// The estimated progress of the mailbox export job, in percentage points.
    estimated_progress: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the symmetric AWS Key Management Service
    /// (AWS KMS)
    /// key that encrypts the exported mailbox content.
    kms_key_arn: ?[]const u8 = null,

    /// The ARN of the AWS Identity and Access Management (IAM) role that grants
    /// write permission to the Amazon Simple
    /// Storage Service (Amazon S3) bucket.
    role_arn: ?[]const u8 = null,

    /// The name of the S3 bucket.
    s3_bucket_name: ?[]const u8 = null,

    /// The path to the S3 bucket and file that the mailbox export job is exporting
    /// to.
    s3_path: ?[]const u8 = null,

    /// The S3 bucket prefix.
    s3_prefix: ?[]const u8 = null,

    /// The mailbox export job start timestamp.
    start_time: ?i64 = null,

    /// The state of the mailbox export job.
    state: ?MailboxExportJobState = null,

    pub const json_field_names = .{
        .description = "Description",
        .end_time = "EndTime",
        .entity_id = "EntityId",
        .error_info = "ErrorInfo",
        .estimated_progress = "EstimatedProgress",
        .kms_key_arn = "KmsKeyArn",
        .role_arn = "RoleArn",
        .s3_bucket_name = "S3BucketName",
        .s3_path = "S3Path",
        .s3_prefix = "S3Prefix",
        .start_time = "StartTime",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMailboxExportJobInput, options: CallOptions) !DescribeMailboxExportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workmail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMailboxExportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workmail", "WorkMail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.DescribeMailboxExportJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMailboxExportJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeMailboxExportJobOutput, body, allocator);
}
