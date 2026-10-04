const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const User = @import("user.zig").User;
const serde = @import("serde.zig");

pub const GetUserInput = struct {
    /// The name of the user to get information about.
    ///
    /// This parameter is optional. If it is not included, it defaults to the user
    /// making the
    /// request. This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of upper and lowercase alphanumeric
    /// characters with no spaces. You can also include any of the following
    /// characters: _+=,.@-
    user_name: ?[]const u8 = null,
};

pub const GetUserOutput = struct {
    /// A structure containing details about the IAM user.
    ///
    /// Due to a service issue, password last used data does not include password
    /// use from
    /// May 3, 2018 22:50 PDT to May 23, 2018 14:08 PDT. This affects [last
    /// sign-in](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_finding-unused.html) dates shown in the IAM console and password last used
    /// dates in the [IAM credential
    /// report](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_getting-report.html), and returned by this operation. If users signed in during the
    /// affected time, the password last used date that is returned is the date the
    /// user
    /// last signed in before May 3, 2018. For users that signed in after May 23,
    /// 2018 14:08
    /// PDT, the returned password last used date is accurate.
    ///
    /// You can use password last used information to identify unused credentials
    /// for
    /// deletion. For example, you might delete users who did not sign in to Amazon
    /// Web Services in the
    /// last 90 days. In cases like this, we recommend that you adjust your
    /// evaluation
    /// window to include dates after May 23, 2018. Alternatively, if your users use
    /// access
    /// keys to access Amazon Web Services programmatically you can refer to access
    /// key last used
    /// information because it is accurate for all dates.
    user: ?User = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUserInput, options: CallOptions) !GetUserOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetUser&Version=2010-05-08");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUserOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetUserResult")) break;
            },
            else => {},
        }
    }

    var result: GetUserOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "User")) {
                    result.user = try serde.deserializeUser(allocator, &reader);
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
