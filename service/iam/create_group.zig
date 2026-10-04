const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Group = @import("group.zig").Group;
const serde = @import("serde.zig");

pub const CreateGroupInput = struct {
    /// The name of the group to create. Do not include the path in this value.
    ///
    /// IAM user, group, role, and policy names must be unique within the account.
    /// Names are
    /// not distinguished by case. For example, you cannot create resources named
    /// both
    /// "MyResource" and "myresource".
    group_name: []const u8,

    /// The path to the group. For more information about paths, see [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the *IAM User Guide*.
    ///
    /// This parameter is optional. If it is not included, it defaults to a slash
    /// (/).
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of either a forward slash (/) by itself or a string that must begin and end
    /// with forward slashes.
    /// In addition, it can contain any ASCII character from the ! (`\u0021`)
    /// through the DEL character (`\u007F`), including
    /// most punctuation characters, digits, and upper and lowercased letters.
    path: ?[]const u8 = null,
};

pub const CreateGroupOutput = struct {
    /// A structure containing details about the new group.
    group: ?Group = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGroupInput, options: CallOptions) !CreateGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateGroup&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&GroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.group_name);
    if (input.path) |v| {
        try body_buf.appendSlice(allocator, "&Path=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateGroupResult")) break;
            },
            else => {},
        }
    }

    var result: CreateGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Group")) {
                    result.group = try serde.deserializeGroup(allocator, &reader);
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
