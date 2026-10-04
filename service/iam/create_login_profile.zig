const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LoginProfile = @import("login_profile.zig").LoginProfile;
const serde = @import("serde.zig");

pub const CreateLoginProfileInput = struct {
    /// The new password for the user.
    ///
    /// This parameter must be omitted when you make the request with an
    /// [AssumeRoot](https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRoot.html) session. It is required in all other cases.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex)
    /// that is used to validate this parameter is a string of characters. That
    /// string can include almost any printable
    /// ASCII character from the space (`\u0020`) through the end of the ASCII
    /// character range (`\u00FF`).
    /// You can also include the tab (`\u0009`), line feed (`\u000A`), and carriage
    /// return (`\u000D`)
    /// characters. Any of these characters are valid in a password. However, many
    /// tools, such
    /// as the Amazon Web Services Management Console, might restrict the ability to
    /// type certain characters because they have
    /// special meaning within that tool.
    password: ?[]const u8 = null,

    /// Specifies whether the user is required to set a new password on next
    /// sign-in.
    password_reset_required: ?bool = null,

    /// The name of the IAM user to create a password for. The user must already
    /// exist.
    ///
    /// This parameter is optional. If no user name is included, it defaults to the
    /// principal
    /// making the request. When you make this request with root user credentials,
    /// you must use
    /// an
    /// [AssumeRoot](https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRoot.html) session to omit the user name.
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of upper and lowercase alphanumeric
    /// characters with no spaces. You can also include any of the following
    /// characters: _+=,.@-
    user_name: ?[]const u8 = null,
};

pub const CreateLoginProfileOutput = struct {
    /// A structure containing the user name and password create date.
    login_profile: ?LoginProfile = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLoginProfileInput, options: CallOptions) !CreateLoginProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iam", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLoginProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateLoginProfile&Version=2010-05-08");
    if (input.password) |v| {
        try body_buf.appendSlice(allocator, "&Password=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.password_reset_required) |v| {
        try body_buf.appendSlice(allocator, "&PasswordResetRequired=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.user_name) |v| {
        try body_buf.appendSlice(allocator, "&UserName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLoginProfileOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateLoginProfileResult")) break;
            },
            else => {},
        }
    }

    var result: CreateLoginProfileOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LoginProfile")) {
                    result.login_profile = try serde.deserializeLoginProfile(allocator, &reader);
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
