const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PrimaryEmailUpdateStatus = @import("primary_email_update_status.zig").PrimaryEmailUpdateStatus;

pub const StartPrimaryEmailUpdateInput = struct {
    /// Specifies the 12-digit account ID number of the Amazon Web Services account
    /// that you want to access or modify with this operation. To use this
    /// parameter, the caller must be an identity in the [organization's management
    /// account](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html#account) or a delegated administrator account. The specified account ID must be a member account in the same organization. The organization must have [all features enabled](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_org_support-all-features.html), and the organization must have [trusted access](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services.html) enabled for the Account Management service, and optionally a [delegated admin](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html#delegated-admin) account assigned.
    ///
    /// This operation can only be called from the management account or the
    /// delegated administrator account of an organization for a member account.
    ///
    /// The management account can't specify its own `AccountId`.
    account_id: []const u8,

    /// The new primary email address (also known as the root user email address) to
    /// use in the specified account.
    primary_email: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .primary_email = "PrimaryEmail",
    };
};

pub const StartPrimaryEmailUpdateOutput = struct {
    /// The status of the primary email update request.
    status: ?PrimaryEmailUpdateStatus = null,

    pub const json_field_names = .{
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartPrimaryEmailUpdateInput, options: CallOptions) !StartPrimaryEmailUpdateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "account", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartPrimaryEmailUpdateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("account", "Account", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/startPrimaryEmailUpdate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AccountId\":");
    try aws.json.writeValue(@TypeOf(input.account_id), input.account_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PrimaryEmail\":");
    try aws.json.writeValue(@TypeOf(input.primary_email), input.primary_email, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartPrimaryEmailUpdateOutput {
    var result: StartPrimaryEmailUpdateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartPrimaryEmailUpdateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
