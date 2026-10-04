const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuditReportResponseFormat = @import("audit_report_response_format.zig").AuditReportResponseFormat;

pub const CreateCertificateAuthorityAuditReportInput = struct {
    /// The format in which to create the report. This can be either **JSON** or
    /// **CSV**.
    audit_report_response_format: AuditReportResponseFormat,

    /// The Amazon Resource Name (ARN) of the CA to be audited. This is of the form:
    ///
    /// `arn:aws:acm-pca:*region*:*account*:certificate-authority/*12345678-1234-1234-1234-123456789012* `.
    certificate_authority_arn: []const u8,

    /// The name of the S3 bucket that will contain the audit report.
    s3_bucket_name: []const u8,

    pub const json_field_names = .{
        .audit_report_response_format = "AuditReportResponseFormat",
        .certificate_authority_arn = "CertificateAuthorityArn",
        .s3_bucket_name = "S3BucketName",
    };
};

pub const CreateCertificateAuthorityAuditReportOutput = struct {
    /// An alphanumeric string that contains a report identifier.
    audit_report_id: ?[]const u8 = null,

    /// The **key** that uniquely identifies the report file in your S3 bucket.
    s3_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .audit_report_id = "AuditReportId",
        .s3_key = "S3Key",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCertificateAuthorityAuditReportInput, options: CallOptions) !CreateCertificateAuthorityAuditReportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "acm-pca", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCertificateAuthorityAuditReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("acm-pca", "ACM PCA", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ACMPrivateCA.CreateCertificateAuthorityAuditReport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCertificateAuthorityAuditReportOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCertificateAuthorityAuditReportOutput, body, allocator);
}
