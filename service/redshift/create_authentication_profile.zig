const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateAuthenticationProfileInput = struct {
    /// The content of the authentication profile in JSON format.
    /// The maximum length of the JSON string is determined by a quota for your
    /// account.
    authentication_profile_content: []const u8,

    /// The name of the authentication profile to be created.
    authentication_profile_name: []const u8,
};

pub const CreateAuthenticationProfileOutput = struct {
    /// The content of the authentication profile in JSON format.
    authentication_profile_content: ?[]const u8 = null,

    /// The name of the authentication profile that was created.
    authentication_profile_name: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAuthenticationProfileInput, options: CallOptions) !CreateAuthenticationProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAuthenticationProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateAuthenticationProfile&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&AuthenticationProfileContent=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.authentication_profile_content);
    try body_buf.appendSlice(allocator, "&AuthenticationProfileName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.authentication_profile_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAuthenticationProfileOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateAuthenticationProfileResult")) break;
            },
            else => {},
        }
    }

    var result: CreateAuthenticationProfileOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AuthenticationProfileContent")) {
                    result.authentication_profile_content = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AuthenticationProfileName")) {
                    result.authentication_profile_name = try allocator.dupe(u8, try reader.readElementText());
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
