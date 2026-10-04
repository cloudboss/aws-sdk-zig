const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartMailboxExportJobInput = struct {
    /// The idempotency token for the client request.
    client_token: []const u8,

    /// The mailbox export job description.
    description: ?[]const u8 = null,

    /// The identifier of the user or resource associated with the mailbox.
    ///
    /// The identifier can accept *UserId or ResourceId*, *Username or
    /// Resourcename*, or *email*. The following identity formats are available:
    ///
    /// * Entity ID: 12345678-1234-1234-1234-123456789012,
    ///   r-0123456789a0123456789b0123456789
    /// , or S-1-1-12-1234567890-123456789-123456789-1234
    ///
    /// * Email address: entity@domain.tld
    ///
    /// * Entity name: entity
    entity_id: []const u8,

    /// The Amazon Resource Name (ARN) of the symmetric AWS Key Management Service
    /// (AWS KMS)
    /// key that encrypts the exported mailbox content.
    kms_key_arn: []const u8,

    /// The identifier associated with the organization.
    organization_id: []const u8,

    /// The ARN of the AWS Identity and Access Management (IAM) role that grants
    /// write permission to the S3
    /// bucket.
    role_arn: []const u8,

    /// The name of the S3 bucket.
    s3_bucket_name: []const u8,

    /// The S3 bucket prefix.
    s3_prefix: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .entity_id = "EntityId",
        .kms_key_arn = "KmsKeyArn",
        .organization_id = "OrganizationId",
        .role_arn = "RoleArn",
        .s3_bucket_name = "S3BucketName",
        .s3_prefix = "S3Prefix",
    };
};

pub const StartMailboxExportJobOutput = struct {
    /// The job ID.
    job_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMailboxExportJobInput, options: CallOptions) !StartMailboxExportJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartMailboxExportJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.StartMailboxExportJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartMailboxExportJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartMailboxExportJobOutput, body, allocator);
}
