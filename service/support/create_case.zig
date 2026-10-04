const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateCaseInput = struct {
    /// The ID of a set of one or more attachments for the case. Create the set by
    /// using the
    /// AddAttachmentsToSet operation. Each attachment in the set must be 5
    /// MB or smaller. To attach files larger than 5 MB, use `uploadIds`.
    attachment_set_id: ?[]const u8 = null,

    /// The category of problem for the support case. You also use the
    /// DescribeServices operation to get the category code for a service. Each
    /// Amazon Web Services service defines its own set of category codes.
    category_code: ?[]const u8 = null,

    /// A list of email addresses that Amazon Web Services Support copies on case
    /// correspondence. Amazon Web Services Support
    /// identifies the account that creates the case when you specify your Amazon
    /// Web Services credentials in
    /// an HTTP POST method or use the [Amazon Web Services
    /// SDKs](http://aws.amazon.com/tools/).
    cc_email_addresses: ?[]const []const u8 = null,

    /// The communication body text that describes the issue. This text appears in
    /// the
    /// **Description** field on the Amazon Web Services Support Center [Create
    /// Case](https://console.aws.amazon.com/support/home#/case/create) page.
    communication_body: []const u8,

    /// Specifies whether to validate the request without actually creating the
    /// case. When set to
    /// `true`, the request is validated but no case is created, and the operation
    /// returns a `DryRunOperationException`. When omitted or set to `false`, the
    /// request runs normally.
    dry_run: ?bool = null,

    /// The type of issue for the case. You can specify `customer-service` or
    /// `technical`. If you don't specify a value, the default is
    /// `technical`.
    issue_type: ?[]const u8 = null,

    /// The language in which Amazon Web Services Support handles the case. Amazon
    /// Web Services Support
    /// currently supports Chinese (“zh”), English ("en"), Japanese ("ja") , Chinese
    /// ("zh"), Spanish ("es"), Portuguese ("pt"), French ("fr"), Korean (“ko”), and
    /// Turkish ("tr"). You must specify the ISO 639-1
    /// code for the `language` parameter if you want support in that language.
    language: ?[]const u8 = null,

    /// The code for the Amazon Web Services service. You can use the
    /// DescribeServices
    /// operation to get the possible `serviceCode` values.
    service_code: ?[]const u8 = null,

    /// A value that indicates the urgency of the case. This value determines the
    /// response
    /// time according to your service level agreement with Amazon Web Services
    /// Support. You can use the DescribeSeverityLevels operation to get the
    /// possible values for
    /// `severityCode`.
    ///
    /// For more information, see SeverityLevel and [Choosing a
    /// Severity](https://docs.aws.amazon.com/awssupport/latest/user/getting-started.html#choosing-severity) in the *Amazon Web Services Support User Guide*.
    ///
    /// The availability of severity levels depends on the support plan for the
    /// Amazon Web Services account.
    severity_code: ?[]const u8 = null,

    /// The title of the support case. The title appears in the **Subject** field on
    /// the Amazon Web Services Support Center [Create
    /// Case](https://console.aws.amazon.com/support/home#/case/create) page.
    subject: []const u8,

    /// A list of upload IDs that identify attachments to add to the case. Each
    /// `uploadId` is returned by the GetAttachmentUploadLinks
    /// operation. The upload must reach the `attachment-ready` state by calling
    /// CompleteAttachmentUpload before it can be passed here.
    /// Use
    /// `uploadIds` to attach files of any supported size, including files larger
    /// than
    /// 5 MB.
    upload_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .attachment_set_id = "attachmentSetId",
        .category_code = "categoryCode",
        .cc_email_addresses = "ccEmailAddresses",
        .communication_body = "communicationBody",
        .dry_run = "dryRun",
        .issue_type = "issueType",
        .language = "language",
        .service_code = "serviceCode",
        .severity_code = "severityCode",
        .subject = "subject",
        .upload_ids = "uploadIds",
    };
};

pub const CreateCaseOutput = struct {
    /// The support case ID requested or returned in the call. The case ID is an
    /// alphanumeric
    /// string in the following format:
    /// case-*12345678910-exen-2025-c4c1d2bf33c5cf47*
    case_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .case_id = "caseId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCaseInput, options: CallOptions) !CreateCaseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "support", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("support", "Support", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.CreateCase");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCaseOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCaseOutput, body, allocator);
}
