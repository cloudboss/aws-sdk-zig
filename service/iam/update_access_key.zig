const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const statusType = @import("status_type.zig").statusType;

pub const UpdateAccessKeyInput = struct {
    /// The access key ID of the secret access key you want to update.
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters that can
    /// consist of any upper or lowercased letter or digit.
    access_key_id: []const u8,

    /// The status you want to assign to the secret access key. `Active` means
    /// that the key can be used for programmatic calls to Amazon Web Services,
    /// while `Inactive`
    /// means that the key cannot be used.
    status: statusType,

    /// The name of the user whose key you want to update.
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of upper and lowercase alphanumeric
    /// characters with no spaces. You can also include any of the following
    /// characters: _+=,.@-
    user_name: ?[]const u8 = null,
};

pub const UpdateAccessKeyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAccessKeyInput, options: CallOptions) !UpdateAccessKeyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAccessKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=UpdateAccessKey&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&AccessKeyId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.access_key_id);
    try body_buf.appendSlice(allocator, "&Status=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.status.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAccessKeyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: UpdateAccessKeyOutput = .{};

    return result;
}
