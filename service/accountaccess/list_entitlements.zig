const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntitlementFilter = @import("entitlement_filter.zig").EntitlementFilter;
const EntitlementsListMember = @import("entitlements_list_member.zig").EntitlementsListMember;

pub const ListEntitlementsInput = struct {
    /// Specifies the ARN of the application to list entitlements for.
    application_arn: []const u8,

    /// Specifies filter criteria to narrow the entitlements returned. You can
    /// filter by principal, IAM role, or account.
    filter: EntitlementFilter,

    /// Specifies the maximum number of results to return in a single call.
    max_results: ?i32 = null,

    /// Specifies the pagination token from a previous call to retrieve the next set
    /// of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_arn = "applicationArn",
        .filter = "filter",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListEntitlementsOutput = struct {
    /// The list of entitlements for the specified application.
    entitlements: ?[]const EntitlementsListMember = null,

    /// The pagination token to use in a subsequent request to retrieve the next set
    /// of results. This value is null when there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .entitlements = "entitlements",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEntitlementsInput, options: CallOptions) !ListEntitlementsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "account-access", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEntitlementsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("account-access", "Account Access", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/entitlements-list";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"applicationArn\":");
    try aws.json.writeValue(@TypeOf(input.application_arn), input.application_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"filter\":");
    try aws.json.writeValue(@TypeOf(input.filter), input.filter, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEntitlementsOutput {
    const result: ListEntitlementsOutput = try aws.json.parseJsonObject(
        ListEntitlementsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
