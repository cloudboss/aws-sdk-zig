const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GetMembershipAccountDetailError = @import("get_membership_account_detail_error.zig").GetMembershipAccountDetailError;
const GetMembershipAccountDetailItem = @import("get_membership_account_detail_item.zig").GetMembershipAccountDetailItem;

pub const BatchGetMemberAccountDetailsInput = struct {
    /// Optional element to query the membership relationship status to a provided
    /// list of account IDs.
    ///
    /// AWS account ID's may appear less than 12 characters and need to be
    /// zero-prepended. An example would be `123123123` which is nine digits, and
    /// with zero-prepend would be `000123123123`. Not zero-prepending to 12 digits
    /// could result in errors.
    account_ids: []const []const u8,

    /// Required element used in combination with BatchGetMemberAccountDetails to
    /// identify the membership ID to query.
    membership_id: []const u8,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .membership_id = "membershipId",
    };
};

pub const BatchGetMemberAccountDetailsOutput = struct {
    /// The response element providing error messages for requests to
    /// GetMembershipAccountDetails.
    errors: ?[]const GetMembershipAccountDetailError = null,

    /// The response element providing responses for requests to
    /// GetMembershipAccountDetails.
    items: ?[]const GetMembershipAccountDetailItem = null,

    pub const json_field_names = .{
        .errors = "errors",
        .items = "items",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetMemberAccountDetailsInput, options: CallOptions) !BatchGetMemberAccountDetailsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "security-ir", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetMemberAccountDetailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("security-ir", "Security IR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/membership/");
    try path_buf.appendSlice(allocator, input.membership_id);
    try path_buf.appendSlice(allocator, "/batch-member-details");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"accountIds\":");
    try aws.json.writeValue(@TypeOf(input.account_ids), input.account_ids, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetMemberAccountDetailsOutput {
    var result: BatchGetMemberAccountDetailsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetMemberAccountDetailsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
