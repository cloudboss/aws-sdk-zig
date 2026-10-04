const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegistrationStatus = @import("registration_status.zig").RegistrationStatus;
const RegistryType = @import("registry_type.zig").RegistryType;
const serde = @import("serde.zig");

pub const ListTypeRegistrationsInput = struct {
    /// The maximum number of results to be returned with a single call. If the
    /// number of
    /// available results exceeds this maximum, the response includes a `NextToken`
    /// value
    /// that you can assign to the `NextToken` request parameter to get the next set
    /// of
    /// results.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// The current status of the extension registration request.
    ///
    /// The default is `IN_PROGRESS`.
    registration_status_filter: ?RegistrationStatus = null,

    /// The kind of extension.
    ///
    /// Conditional: You must specify either `TypeName` and `Type`, or
    /// `Arn`.
    @"type": ?RegistryType = null,

    /// The Amazon Resource Name (ARN) of the extension.
    ///
    /// Conditional: You must specify either `TypeName` and `Type`, or
    /// `Arn`.
    type_arn: ?[]const u8 = null,

    /// The name of the extension.
    ///
    /// Conditional: You must specify either `TypeName` and `Type`, or
    /// `Arn`.
    type_name: ?[]const u8 = null,
};

pub const ListTypeRegistrationsOutput = struct {
    /// If the request doesn't return all the remaining results, `NextToken` is set
    /// to
    /// a token. To retrieve the next set of results, call this action again and
    /// assign that token to
    /// the request object's `NextToken` parameter. If the request returns all
    /// results,
    /// `NextToken` is set to `null`.
    next_token: ?[]const u8 = null,

    /// A list of extension registration tokens.
    ///
    /// Use DescribeTypeRegistration to return detailed information about a type
    /// registration request.
    registration_token_list: ?[]const []const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTypeRegistrationsInput, options: CallOptions) !ListTypeRegistrationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTypeRegistrationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListTypeRegistrations&Version=2010-05-15");
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.registration_status_filter) |v| {
        try body_buf.appendSlice(allocator, "&RegistrationStatusFilter=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.@"type") |v| {
        try body_buf.appendSlice(allocator, "&Type=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.type_arn) |v| {
        try body_buf.appendSlice(allocator, "&TypeArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.type_name) |v| {
        try body_buf.appendSlice(allocator, "&TypeName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTypeRegistrationsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListTypeRegistrationsResult")) break;
            },
            else => {},
        }
    }

    var result: ListTypeRegistrationsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RegistrationTokenList")) {
                    result.registration_token_list = try serde.deserializeRegistrationTokenList(allocator, &reader, "member");
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
