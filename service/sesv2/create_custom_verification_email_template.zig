const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

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

    /// An array of objects that define the tags (keys and values) to associate with
    /// the
    /// custom verification email template.
    tags: ?[]const Tag = null,

    /// The content of the custom verification email. The total size of the email
    /// must be less
    /// than 10 MB. The message body may contain HTML, with some limitations. For
    /// more
    /// information, see [Custom verification email frequently asked
    /// questions](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html#send-email-verify-address-custom-faq) in the *Amazon SES
    /// Developer Guide*.
    template_content: []const u8,

    /// The name of the custom verification email template.
    template_name: []const u8,

    /// The subject line of the custom verification email.
    template_subject: []const u8,

    pub const json_field_names = .{
        .failure_redirection_url = "FailureRedirectionURL",
        .from_email_address = "FromEmailAddress",
        .success_redirection_url = "SuccessRedirectionURL",
        .tags = "Tags",
        .template_content = "TemplateContent",
        .template_name = "TemplateName",
        .template_subject = "TemplateSubject",
    };
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
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/custom-verification-email-templates";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FailureRedirectionURL\":");
    try aws.json.writeValue(@TypeOf(input.failure_redirection_url), input.failure_redirection_url, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FromEmailAddress\":");
    try aws.json.writeValue(@TypeOf(input.from_email_address), input.from_email_address, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SuccessRedirectionURL\":");
    try aws.json.writeValue(@TypeOf(input.success_redirection_url), input.success_redirection_url, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TemplateContent\":");
    try aws.json.writeValue(@TypeOf(input.template_content), input.template_content, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TemplateName\":");
    try aws.json.writeValue(@TypeOf(input.template_name), input.template_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TemplateSubject\":");
    try aws.json.writeValue(@TypeOf(input.template_subject), input.template_subject, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCustomVerificationEmailTemplateOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: CreateCustomVerificationEmailTemplateOutput = .{};

    return result;
}
