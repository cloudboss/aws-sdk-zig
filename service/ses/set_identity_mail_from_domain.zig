const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BehaviorOnMXFailure = @import("behavior_on_mx_failure.zig").BehaviorOnMXFailure;

pub const SetIdentityMailFromDomainInput = struct {
    /// The action for Amazon SES to take if it cannot successfully read the
    /// required MX record
    /// when you send an email. If you choose `UseDefaultValue`, Amazon SES uses
    /// amazonses.com (or a subdomain of that) as the MAIL FROM domain. If you
    /// choose
    /// `RejectMessage`, Amazon SES returns a `MailFromDomainNotVerified`
    /// error and not send the email.
    ///
    /// The action specified in `BehaviorOnMXFailure` is taken when the custom MAIL
    /// FROM domain setup is in the `Pending`, `Failed`, and
    /// `TemporaryFailure` states.
    behavior_on_mx_failure: ?BehaviorOnMXFailure = null,

    /// The verified identity.
    identity: []const u8,

    /// The custom MAIL FROM domain for the verified identity to use. The MAIL FROM
    /// domain
    /// must 1) be a subdomain of the verified identity, 2) not be used in a "From"
    /// address if
    /// the MAIL FROM domain is the destination of email feedback forwarding (for
    /// more
    /// information, see the [Amazon SES Developer
    /// Guide](https://docs.aws.amazon.com/ses/latest/dg/mail-from.html)), and 3)
    /// not be used to receive emails. A value of
    /// `null` disables the custom MAIL FROM setting for the identity.
    mail_from_domain: ?[]const u8 = null,
};

pub const SetIdentityMailFromDomainOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetIdentityMailFromDomainInput, options: CallOptions) !SetIdentityMailFromDomainOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetIdentityMailFromDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetIdentityMailFromDomain&Version=2010-12-01");
    if (input.behavior_on_mx_failure) |v| {
        try body_buf.appendSlice(allocator, "&BehaviorOnMXFailure=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    try body_buf.appendSlice(allocator, "&Identity=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.identity);
    if (input.mail_from_domain) |v| {
        try body_buf.appendSlice(allocator, "&MailFromDomain=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetIdentityMailFromDomainOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SetIdentityMailFromDomainOutput = .{};

    return result;
}
