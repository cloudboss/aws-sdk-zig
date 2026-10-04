const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegionOptStatus = @import("region_opt_status.zig").RegionOptStatus;
const Region = @import("region.zig").Region;

pub const ListRegionsInput = struct {
    /// Specifies the 12-digit account ID number of the Amazon Web Services account
    /// that you want to access or modify with this operation. If you don't specify
    /// this parameter, it defaults to the Amazon Web Services account of the
    /// identity used to call the operation. To use this parameter, the caller must
    /// be an identity in the [organization's management
    /// account](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html#account) or a delegated administrator account. The specified account ID must be a member account in the same organization. The organization must have [all features enabled](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_org_support-all-features.html), and the organization must have [trusted access](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services.html) enabled for the Account Management service, and optionally a [delegated admin](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html#delegated-admin) account assigned.
    ///
    /// The management account can't specify its own `AccountId`. It must call the
    /// operation in standalone context by not including the `AccountId` parameter.
    ///
    /// To call this operation on an account that is not a member of an
    /// organization, don't specify this parameter. Instead, call the operation
    /// using an identity belonging to the account whose contacts you wish to
    /// retrieve or modify.
    account_id: ?[]const u8 = null,

    /// The total number of items to return in the command’s output. If the total
    /// number of items available is more than the value specified, a `NextToken` is
    /// provided in the command’s output. To resume pagination, provide the
    /// `NextToken` value in the `starting-token` argument of a subsequent command.
    /// Do not use the `NextToken` response element directly outside of the Amazon
    /// Web Services CLI. For usage examples, see
    /// [Pagination](http://docs.aws.amazon.com/cli/latest/userguide/pagination.html) in the *Amazon Web Services Command Line Interface User Guide*.
    max_results: ?i32 = null,

    /// A token used to specify where to start paginating. This is the `NextToken`
    /// from a previously truncated response. For usage examples, see
    /// [Pagination](http://docs.aws.amazon.com/cli/latest/userguide/pagination.html) in the *Amazon Web Services Command Line Interface User Guide*.
    next_token: ?[]const u8 = null,

    /// A list of Region statuses (Enabling, Enabled, Disabling, Disabled,
    /// Enabled_by_default) to use to filter the list of Regions for a given
    /// account. For example, passing in a value of ENABLING will only return a list
    /// of Regions with a Region status of ENABLING.
    region_opt_status_contains: ?[]const RegionOptStatus = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .region_opt_status_contains = "RegionOptStatusContains",
    };
};

pub const ListRegionsOutput = struct {
    /// If there is more data to be returned, this will be populated. It should be
    /// passed into the `next-token` request parameter of `list-regions`.
    next_token: ?[]const u8 = null,

    /// This is a list of Regions for a given account, or if the filtered parameter
    /// was used, a list of Regions that match the filter criteria set in the
    /// `filter` parameter.
    regions: ?[]const Region = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .regions = "Regions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRegionsInput, options: CallOptions) !ListRegionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRegionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("account", "Account", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/listRegions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccountId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.region_opt_status_contains) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RegionOptStatusContains\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRegionsOutput {
    var result: ListRegionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListRegionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
