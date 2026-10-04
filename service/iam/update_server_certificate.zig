const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateServerCertificateInput = struct {
    /// The new path for the server certificate. Include this only if you are
    /// updating the
    /// server certificate's path.
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of either a forward slash (/) by itself or a string that must begin and end
    /// with forward slashes.
    /// In addition, it can contain any ASCII character from the ! (`\u0021`)
    /// through the DEL character (`\u007F`), including
    /// most punctuation characters, digits, and upper and lowercased letters.
    new_path: ?[]const u8 = null,

    /// The new name for the server certificate. Include this only if you are
    /// updating the
    /// server certificate's name. The name of the certificate cannot contain any
    /// spaces.
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of upper and lowercase alphanumeric
    /// characters with no spaces. You can also include any of the following
    /// characters: _+=,.@-
    new_server_certificate_name: ?[]const u8 = null,

    /// The name of the server certificate that you want to update.
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of upper and lowercase alphanumeric
    /// characters with no spaces. You can also include any of the following
    /// characters: _+=,.@-
    server_certificate_name: []const u8,
};

pub const UpdateServerCertificateOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateServerCertificateInput, options: CallOptions) !UpdateServerCertificateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateServerCertificateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=UpdateServerCertificate&Version=2010-05-08");
    if (input.new_path) |v| {
        try body_buf.appendSlice(allocator, "&NewPath=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.new_server_certificate_name) |v| {
        try body_buf.appendSlice(allocator, "&NewServerCertificateName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&ServerCertificateName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.server_certificate_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateServerCertificateOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: UpdateServerCertificateOutput = .{};

    return result;
}
