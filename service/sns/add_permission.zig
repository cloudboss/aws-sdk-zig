const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const AddPermissionInput = struct {
    /// The action you want to allow for the specified principal(s).
    ///
    /// Valid values: Any Amazon SNS action name, for example `Publish`.
    action_name: []const []const u8,

    /// The Amazon Web Services account IDs of the users (principals) who will be
    /// given access to the
    /// specified actions. The users must have Amazon Web Services account, but do
    /// not need to be signed up
    /// for this service.
    aws_account_id: []const []const u8,

    /// A unique identifier for the new policy statement.
    label: []const u8,

    /// The ARN of the topic whose access control policy you wish to modify.
    topic_arn: []const u8,
};

pub const AddPermissionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddPermissionInput, options: CallOptions) !AddPermissionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sns", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddPermissionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=AddPermission&Version=2010-03-31");
    for (input.action_name, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ActionName.member.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
    }
    for (input.aws_account_id, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AWSAccountId.member.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
    }
    try body_buf.appendSlice(allocator, "&Label=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.label);
    try body_buf.appendSlice(allocator, "&TopicArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.topic_arn);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddPermissionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: AddPermissionOutput = .{};

    return result;
}
