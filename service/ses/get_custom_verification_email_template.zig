const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetCustomVerificationEmailTemplateInput = struct {
    /// The name of the custom verification email template to retrieve.
    template_name: []const u8,
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

    /// The content of the custom verification email.
    template_content: ?[]const u8 = null,

    /// The name of the custom verification email template.
    template_name: ?[]const u8 = null,

    /// The subject line of the custom verification email.
    template_subject: ?[]const u8 = null,
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
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetCustomVerificationEmailTemplate&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&TemplateName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.template_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCustomVerificationEmailTemplateOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetCustomVerificationEmailTemplateResult")) break;
            },
            else => {},
        }
    }

    var result: GetCustomVerificationEmailTemplateOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FailureRedirectionURL")) {
                    result.failure_redirection_url = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FromEmailAddress")) {
                    result.from_email_address = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SuccessRedirectionURL")) {
                    result.success_redirection_url = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateContent")) {
                    result.template_content = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateName")) {
                    result.template_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateSubject")) {
                    result.template_subject = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
