const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RelationshipStatus = @import("relationship_status.zig").RelationshipStatus;

pub const GetMemberInput = struct {
    /// The unique identifier for the Amazon Macie resource that the request applies
    /// to.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetMemberOutput = struct {
    /// The Amazon Web Services account ID for the account.
    account_id: ?[]const u8 = null,

    /// The Amazon Web Services account ID for the administrator account.
    administrator_account_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the account.
    arn: ?[]const u8 = null,

    /// The email address for the account. This value is null if the account is
    /// associated with the administrator account through Organizations.
    email: ?[]const u8 = null,

    /// The date and time, in UTC and extended ISO 8601 format, when an Amazon Macie
    /// membership invitation was last sent to the account. This value is null if a
    /// Macie membership invitation hasn't been sent to the account.
    invited_at: ?i64 = null,

    /// (Deprecated) The Amazon Web Services account ID for the administrator
    /// account. This property has been replaced by the administratorAccountId
    /// property and is retained only for backward compatibility.
    master_account_id: ?[]const u8 = null,

    /// The current status of the relationship between the account and the
    /// administrator account.
    relationship_status: ?RelationshipStatus = null,

    /// A map of key-value pairs that specifies which tags (keys and values) are
    /// associated with the account in Amazon Macie.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The date and time, in UTC and extended ISO 8601 format, of the most recent
    /// change to the status of the relationship between the account and the
    /// administrator account.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .administrator_account_id = "administratorAccountId",
        .arn = "arn",
        .email = "email",
        .invited_at = "invitedAt",
        .master_account_id = "masterAccountId",
        .relationship_status = "relationshipStatus",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMemberInput, options: CallOptions) !GetMemberOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMemberInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/members/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMemberOutput {
    const result: GetMemberOutput = try aws.json.parseJsonObject(
        GetMemberOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
