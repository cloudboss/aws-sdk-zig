const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetMailboxDetailsInput = struct {
    /// The identifier for the organization that contains the user whose mailbox
    /// details are
    /// being requested.
    organization_id: []const u8,

    /// The identifier for the user whose mailbox details are being requested.
    ///
    /// The identifier can be the *UserId*, *Username*, or *email*. The following
    /// identity formats are available:
    ///
    /// * User ID: 12345678-1234-1234-1234-123456789012 or
    ///   S-1-1-12-1234567890-123456789-123456789-1234
    ///
    /// * Email address: user@domain.tld
    ///
    /// * User name: user
    user_id: []const u8,

    pub const json_field_names = .{
        .organization_id = "OrganizationId",
        .user_id = "UserId",
    };
};

pub const GetMailboxDetailsOutput = struct {
    /// The maximum allowed mailbox size, in MB, for the specified user.
    mailbox_quota: ?i32 = null,

    /// The current mailbox size, in MB, for the specified user.
    mailbox_size: ?f64 = null,

    pub const json_field_names = .{
        .mailbox_quota = "MailboxQuota",
        .mailbox_size = "MailboxSize",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMailboxDetailsInput, options: CallOptions) !GetMailboxDetailsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workmail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMailboxDetailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workmail", "WorkMail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.GetMailboxDetails");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMailboxDetailsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetMailboxDetailsOutput, body, allocator);
}
