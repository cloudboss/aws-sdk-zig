const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ChangePasswordInput = struct {
    /// The new password. The new password must conform to the Amazon Web Services
    /// account's password
    /// policy, if one exists.
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
    new_password: []const u8,

    /// The IAM user's current password.
    old_password: []const u8,
};

pub const ChangePasswordOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ChangePasswordInput, options: CallOptions) !ChangePasswordOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ChangePasswordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ChangePassword&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&NewPassword=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.new_password);
    try body_buf.appendSlice(allocator, "&OldPassword=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.old_password);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ChangePasswordOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: ChangePasswordOutput = .{};

    return result;
}
