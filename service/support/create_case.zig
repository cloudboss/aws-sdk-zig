const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const CreateCaseInput = struct {
    /// The ID of a set of one or more attachments for the case. Create the set by
    /// using the
    /// AddAttachmentsToSet operation.
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

    /// The type of issue for the case. You can specify `customer-service` or
    /// `technical`. If you don't specify a value, the default is
    /// `technical`.
    issue_type: ?[]const u8 = null,

    /// The language in which Amazon Web Services Support handles the case. Amazon
    /// Web Services Support
    /// currently supports Chinese (“zh”), English ("en"), Japanese ("ja") and
    /// Korean (“ko”). You must specify the ISO 639-1
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

    pub const json_field_names = .{
        .attachment_set_id = "attachmentSetId",
        .category_code = "categoryCode",
        .cc_email_addresses = "ccEmailAddresses",
        .communication_body = "communicationBody",
        .issue_type = "issueType",
        .language = "language",
        .service_code = "serviceCode",
        .severity_code = "severityCode",
        .subject = "subject",
    };
};

pub const CreateCaseOutput = struct {
    /// The support case ID requested or returned in the call. The case ID is an
    /// alphanumeric
    /// string in the following format:
    /// case-*12345678910-2013-c4c1d2bf33c5cf47*
    case_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .case_id = "caseId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCaseInput, options: Options) !CreateCaseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "support");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("support", "Support", allocator);

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

    if (std.mem.eql(u8, error_code, "AttachmentIdNotFound")) {
        return .{ .arena = arena, .kind = .{ .attachment_id_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AttachmentLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .attachment_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AttachmentSetExpired")) {
        return .{ .arena = arena, .kind = .{ .attachment_set_expired = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AttachmentSetIdNotFound")) {
        return .{ .arena = arena, .kind = .{ .attachment_set_id_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AttachmentSetSizeLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .attachment_set_size_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CaseCreationLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .case_creation_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CaseIdNotFound")) {
        return .{ .arena = arena, .kind = .{ .case_id_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DescribeAttachmentLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .describe_attachment_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
