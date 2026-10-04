const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateCustomVerificationEmailTemplateInput = struct {
    /// The URL that the recipient of the verification email is sent to if his or
    /// her address
    /// is not successfully verified.
    failure_redirection_url: []const u8,

    /// The email address that the custom verification email is sent from.
    from_email_address: []const u8,

    /// The URL that the recipient of the verification email is sent to if his or
    /// her address
    /// is successfully verified.
    success_redirection_url: []const u8,

    /// The content of the custom verification email. The total size of the email
    /// must be less
    /// than 10 MB. The message body may contain HTML, with some limitations. For
    /// more
    /// information, see [Custom
    /// Verification Email Frequently Asked
    /// Questions](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html#send-email-verify-address-custom) in the *Amazon SES
    /// Developer Guide*.
    template_content: []const u8,

    /// The name of the custom verification email template.
    template_name: []const u8,

    /// The subject line of the custom verification email.
    template_subject: []const u8,
};

pub const CreateCustomVerificationEmailTemplateOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCustomVerificationEmailTemplateInput, options: CallOptions) !CreateCustomVerificationEmailTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCustomVerificationEmailTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateCustomVerificationEmailTemplate&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&FailureRedirectionURL=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.failure_redirection_url);
    try body_buf.appendSlice(allocator, "&FromEmailAddress=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.from_email_address);
    try body_buf.appendSlice(allocator, "&SuccessRedirectionURL=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.success_redirection_url);
    try body_buf.appendSlice(allocator, "&TemplateContent=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.template_content);
    try body_buf.appendSlice(allocator, "&TemplateName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.template_name);
    try body_buf.appendSlice(allocator, "&TemplateSubject=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.template_subject);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCustomVerificationEmailTemplateOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: CreateCustomVerificationEmailTemplateOutput = .{};

    return result;
}
