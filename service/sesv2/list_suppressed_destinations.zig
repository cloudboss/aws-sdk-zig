const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SuppressionListReason = @import("suppression_list_reason.zig").SuppressionListReason;
const SuppressedDestinationSummary = @import("suppressed_destination_summary.zig").SuppressedDestinationSummary;

pub const ListSuppressedDestinationsInput = struct {
    /// Used to filter the list of suppressed email destinations so that it only
    /// includes
    /// addresses that were added to the list before a specific date.
    end_date: ?i64 = null,

    /// A token returned from a previous call to `ListSuppressedDestinations` to
    /// indicate the position in the list of suppressed email addresses.
    next_token: ?[]const u8 = null,

    /// The number of results to show in a single call to
    /// `ListSuppressedDestinations`. If the number of results is larger than the
    /// number you specified in this parameter, then the response includes a
    /// `NextToken` element, which you can use to obtain additional
    /// results.
    page_size: ?i32 = null,

    /// The factors that caused the email address to be added to the suppression
    /// list for
    /// your account or for a specific tenant.
    reasons: ?[]const SuppressionListReason = null,

    /// Used to filter the list of suppressed email destinations so that it only
    /// includes
    /// addresses that were added to the list after a specific date.
    start_date: ?i64 = null,

    /// The name of the tenant whose suppression list you want to retrieve. If you
    /// omit this
    /// parameter, the operation targets the account-level suppression list.
    tenant_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_date = "EndDate",
        .next_token = "NextToken",
        .page_size = "PageSize",
        .reasons = "Reasons",
        .start_date = "StartDate",
        .tenant_name = "TenantName",
    };
};

pub const ListSuppressedDestinationsOutput = struct {
    /// A token that indicates that there are additional email addresses on the
    /// suppression
    /// list for your account or for the specified tenant. To view additional
    /// suppressed
    /// addresses, issue another request to `ListSuppressedDestinations`, and pass
    /// this token in the `NextToken` parameter.
    next_token: ?[]const u8 = null,

    /// A list of summaries, each containing a summary for a suppressed email
    /// destination.
    suppressed_destination_summaries: ?[]const SuppressedDestinationSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .suppressed_destination_summaries = "SuppressedDestinationSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSuppressedDestinationsInput, options: CallOptions) !ListSuppressedDestinationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSuppressedDestinationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/suppression/addresses";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.end_date) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "EndDate=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.page_size) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "PageSize=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.reasons) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "Reason=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    if (input.start_date) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "StartDate=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.tenant_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "TenantName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSuppressedDestinationsOutput {
    const result: ListSuppressedDestinationsOutput = try aws.json.parseJsonObject(
        ListSuppressedDestinationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
