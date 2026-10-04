const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthenticationMode = @import("authentication_mode.zig").AuthenticationMode;
const Authentication = @import("authentication.zig").Authentication;
const serde = @import("serde.zig");

pub const ModifyUserInput = struct {
    /// Access permissions string used for this user.
    access_string: ?[]const u8 = null,

    /// Adds additional user permissions to the access string.
    append_access_string: ?[]const u8 = null,

    /// Specifies how to authenticate the user.
    authentication_mode: ?AuthenticationMode = null,

    /// Modifies the engine listed for a user. The options are valkey or redis.
    engine: ?[]const u8 = null,

    /// Indicates no password is required for the user.
    no_password_required: ?bool = null,

    /// The passwords belonging to the user. You are allowed up to two.
    passwords: ?[]const []const u8 = null,

    /// The ID of the user.
    user_id: []const u8,
};

pub const ModifyUserOutput = @import("user.zig").User;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyUserInput, options: CallOptions) !ModifyUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticache", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyUser&Version=2015-02-02");
    if (input.access_string) |v| {
        try body_buf.appendSlice(allocator, "&AccessString=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.append_access_string) |v| {
        try body_buf.appendSlice(allocator, "&AppendAccessString=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.authentication_mode) |v| {
        if (v.passwords) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AuthenticationMode.Passwords.member.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item);
            }
        }
        if (v.@"type") |sv| {
            try body_buf.appendSlice(allocator, "&AuthenticationMode.Type=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
    }
    if (input.engine) |v| {
        try body_buf.appendSlice(allocator, "&Engine=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.no_password_required) |v| {
        try body_buf.appendSlice(allocator, "&NoPasswordRequired=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.passwords) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Passwords.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    try body_buf.appendSlice(allocator, "&UserId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.user_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyUserOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyUserResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyUserOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessString")) {
                    result.access_string = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ARN")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Authentication")) {
                    result.authentication = try serde.deserializeAuthentication(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MinimumEngineVersion")) {
                    result.minimum_engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserGroupIds")) {
                    result.user_group_ids = try serde.deserializeUserGroupIdList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "UserId")) {
                    result.user_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try allocator.dupe(u8, try reader.readElementText());
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
