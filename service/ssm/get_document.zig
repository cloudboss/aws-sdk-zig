const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DocumentFormat = @import("document_format.zig").DocumentFormat;
const AttachmentContent = @import("attachment_content.zig").AttachmentContent;
const DocumentType = @import("document_type.zig").DocumentType;
const DocumentRequires = @import("document_requires.zig").DocumentRequires;
const ReviewStatus = @import("review_status.zig").ReviewStatus;
const DocumentStatus = @import("document_status.zig").DocumentStatus;

pub const GetDocumentInput = struct {
    /// Returns the document in the specified format. The document format can be
    /// either JSON or
    /// YAML. JSON is the default format.
    document_format: ?DocumentFormat = null,

    /// The document version for which you want information.
    document_version: ?[]const u8 = null,

    /// The name of the SSM document.
    name: []const u8,

    /// An optional field specifying the version of the artifact associated with the
    /// document. For
    /// example, 12.6. This value is unique across all versions of a document and
    /// can't be
    /// changed.
    version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .document_format = "DocumentFormat",
        .document_version = "DocumentVersion",
        .name = "Name",
        .version_name = "VersionName",
    };
};

pub const GetDocumentOutput = struct {
    /// A description of the document attachments, including names, locations,
    /// sizes, and so
    /// on.
    attachments_content: ?[]const AttachmentContent = null,

    /// The contents of the SSM document.
    content: ?[]const u8 = null,

    /// The date the SSM document was created.
    created_date: ?i64 = null,

    /// The friendly name of the SSM document. This value can differ for each
    /// version of the
    /// document. If you want to update this value, see UpdateDocument.
    display_name: ?[]const u8 = null,

    /// The document format, either JSON or YAML.
    document_format: ?DocumentFormat = null,

    /// The document type.
    document_type: ?DocumentType = null,

    /// The document version.
    document_version: ?[]const u8 = null,

    /// The name of the SSM document.
    name: ?[]const u8 = null,

    /// A list of SSM documents required by a document. For example, an
    /// `ApplicationConfiguration` document requires an
    /// `ApplicationConfigurationSchema` document.
    requires: ?[]const DocumentRequires = null,

    /// The current review status of a new custom Systems Manager document (SSM
    /// document) created by a member
    /// of your organization, or of the latest version of an existing SSM document.
    ///
    /// Only one version of an SSM document can be in the APPROVED state at a time.
    /// When a new
    /// version is approved, the status of the previous version changes to REJECTED.
    ///
    /// Only one version of an SSM document can be in review, or PENDING, at a time.
    review_status: ?ReviewStatus = null,

    /// The status of the SSM document, such as `Creating`, `Active`,
    /// `Updating`, `Failed`, and `Deleting`.
    status: ?DocumentStatus = null,

    /// A message returned by Amazon Web Services Systems Manager that explains the
    /// `Status` value. For example, a
    /// `Failed` status might be explained by the `StatusInformation` message,
    /// "The specified S3 bucket doesn't exist. Verify that the URL of the S3 bucket
    /// is correct."
    status_information: ?[]const u8 = null,

    /// The version of the artifact associated with the document. For example, 12.6.
    /// This value is
    /// unique across all versions of a document, and can't be changed.
    version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachments_content = "AttachmentsContent",
        .content = "Content",
        .created_date = "CreatedDate",
        .display_name = "DisplayName",
        .document_format = "DocumentFormat",
        .document_type = "DocumentType",
        .document_version = "DocumentVersion",
        .name = "Name",
        .requires = "Requires",
        .review_status = "ReviewStatus",
        .status = "Status",
        .status_information = "StatusInformation",
        .version_name = "VersionName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDocumentInput, options: CallOptions) !GetDocumentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDocumentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.GetDocument");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDocumentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDocumentOutput, body, allocator);
}
