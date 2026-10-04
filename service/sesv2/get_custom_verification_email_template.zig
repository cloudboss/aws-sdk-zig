const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const GetCustomVerificationEmailTemplateInput = struct {
    /// The name of the custom verification email template that you want to
    /// retrieve.
    template_name: []const u8,

    pub const json_field_names = .{
        .template_name = "TemplateName",
    };
};

pub const GetCustomVerificationEmailTemplateOutput = struct {
    /// The URL that the recipient of the verification email is sent to if his or
    /// her address
    /// is not successfully verified.
    failure_redirection_url: ?[]const u8 = null,

    /// The email address that the custom verification email is sent from.
    from_email_address: ?[]const u8 = null,

    /// The URL that the recipient of the verification email is sent to if his or
    /// her address
    /// is successfully verified.
    success_redirection_url: ?[]const u8 = null,

    /// An array of objects that define the tags (keys and values) that are
    /// associated with
    /// the custom verification email template.
    tags: ?[]const Tag = null,

    /// The content of the custom verification email.
    template_content: ?[]const u8 = null,

    /// The name of the custom verification email template.
    template_name: ?[]const u8 = null,

    /// The subject line of the custom verification email.
    template_subject: ?[]const u8 = null,

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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCustomVerificationEmailTemplateInput, options: CallOptions) !GetCustomVerificationEmailTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCustomVerificationEmailTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/email/custom-verification-email-templates/");
    try path_buf.appendSlice(allocator, input.template_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCustomVerificationEmailTemplateOutput {
    const result: GetCustomVerificationEmailTemplateOutput = try aws.json.parseJsonObject(
        GetCustomVerificationEmailTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
