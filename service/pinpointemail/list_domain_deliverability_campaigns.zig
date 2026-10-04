const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainDeliverabilityCampaign = @import("domain_deliverability_campaign.zig").DomainDeliverabilityCampaign;

pub const ListDomainDeliverabilityCampaignsInput = struct {
    /// The last day, in Unix time format, that you want to obtain deliverability
    /// data for.
    /// This value has to be less than or equal to 30 days after the value of the
    /// `StartDate` parameter.
    end_date: i64,

    /// A token that’s returned from a previous call to the
    /// `ListDomainDeliverabilityCampaigns` operation. This token indicates the
    /// position of a campaign in the list of campaigns.
    next_token: ?[]const u8 = null,

    /// The maximum number of results to include in response to a single call to the
    /// `ListDomainDeliverabilityCampaigns` operation. If the number of results
    /// is larger than the number that you specify in this parameter, the response
    /// includes a
    /// `NextToken` element, which you can use to obtain additional
    /// results.
    page_size: ?i32 = null,

    /// The first day, in Unix time format, that you want to obtain deliverability
    /// data
    /// for.
    start_date: i64,

    /// The domain to obtain deliverability data for.
    subscribed_domain: []const u8,

    pub const json_field_names = .{
        .end_date = "EndDate",
        .next_token = "NextToken",
        .page_size = "PageSize",
        .start_date = "StartDate",
        .subscribed_domain = "SubscribedDomain",
    };
};

pub const ListDomainDeliverabilityCampaignsOutput = struct {
    /// An array of responses, one for each campaign that used the domain to send
    /// email during
    /// the specified time range.
    domain_deliverability_campaigns: ?[]const DomainDeliverabilityCampaign = null,

    /// A token that’s returned from a previous call to the
    /// `ListDomainDeliverabilityCampaigns` operation. This token indicates the
    /// position of the campaign in the list of campaigns.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_deliverability_campaigns = "DomainDeliverabilityCampaigns",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDomainDeliverabilityCampaignsInput, options: CallOptions) !ListDomainDeliverabilityCampaignsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDomainDeliverabilityCampaignsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "Pinpoint Email", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/email/deliverability-dashboard/domains/");
    try path_buf.appendSlice(allocator, input.subscribed_domain);
    try path_buf.appendSlice(allocator, "/campaigns");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "EndDate=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.end_date}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
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
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "StartDate=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.start_date}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDomainDeliverabilityCampaignsOutput {
    const result: ListDomainDeliverabilityCampaignsOutput = try aws.json.parseJsonObject(
        ListDomainDeliverabilityCampaignsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
