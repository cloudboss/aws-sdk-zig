const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetCallerIdentityInput = struct {};

pub const GetCallerIdentityOutput = struct {
    /// The Amazon Web Services account ID number of the account that owns or
    /// contains the calling
    /// entity.
    account: ?[]const u8 = null,

    /// The Amazon Web Services ARN associated with the calling entity.
    arn: ?[]const u8 = null,

    /// The unique identifier of the calling entity. The exact value depends on the
    /// type of
    /// entity that is making the call. The values returned are those listed in the
    /// **aws:userid** column in the [Principal
    /// table](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_variables.html#principaltable) found on the **Policy Variables** reference
    /// page in the *IAM User Guide*.
    user_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCallerIdentityInput, options: CallOptions) !GetCallerIdentityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sts", client.config.http_client.clock_skew_offset);

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

pub const PresignOptions = struct {
    expires_seconds: u64 = 3600,
};

pub fn presign(client: *Client, allocator: std.mem.Allocator, input: GetCallerIdentityInput, options: PresignOptions) ![]const u8 {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);

    return aws.signing.presignRequest(
        allocator,
        client.config.io,
        &request,
        creds,
        client.config.region,
        "sts",
        .{ .expires_seconds = options.expires_seconds },
        client.config.http_client.clock_skew_offset,
    );
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetCallerIdentityInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("sts", "STS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetCallerIdentity&Version=2011-06-15");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCallerIdentityOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetCallerIdentityResult")) break;
            },
            else => {},
        }
    }

    var result: GetCallerIdentityOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Account")) {
                    result.account = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserId")) {
                    result.user_id = try allocator.dupe(u8, try reader.readElementText());
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
