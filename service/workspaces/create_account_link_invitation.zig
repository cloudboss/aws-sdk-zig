const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountLink = @import("account_link.zig").AccountLink;

pub const CreateAccountLinkInvitationInput = struct {
    /// A string of up to 64 ASCII characters that Amazon WorkSpaces uses to ensure
    /// idempotent creation.
    client_token: ?[]const u8 = null,

    /// The identifier of the target account.
    target_account_id: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .target_account_id = "TargetAccountId",
    };
};

pub const CreateAccountLinkInvitationOutput = struct {
    /// Information about the account link.
    account_link: ?AccountLink = null,

    pub const json_field_names = .{
        .account_link = "AccountLink",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAccountLinkInvitationInput, options: CallOptions) !CreateAccountLinkInvitationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAccountLinkInvitationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces", "WorkSpaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.CreateAccountLinkInvitation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAccountLinkInvitationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAccountLinkInvitationOutput, body, allocator);
}
