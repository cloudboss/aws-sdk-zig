const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationPolicySummary = @import("configuration_policy_summary.zig").ConfigurationPolicySummary;

pub const ListConfigurationPoliciesInput = struct {
    /// The maximum number of results that's returned by `ListConfigurationPolicies`
    /// in each page of the response.
    /// When this parameter is used, `ListConfigurationPolicies` returns the
    /// specified number of results in a
    /// single page and a `NextToken` response element. You can see the remaining
    /// results of the initial request
    /// by sending another `ListConfigurationPolicies` request with the returned
    /// `NextToken` value. A
    /// valid range for `MaxResults` is between 1 and 100.
    max_results: ?i32 = null,

    /// The NextToken value that's returned from a previous paginated
    /// `ListConfigurationPolicies` request where
    /// `MaxResults` was used but the results exceeded the value of that parameter.
    /// Pagination continues from the
    /// `MaxResults` was used but the results exceeded the value of that parameter.
    /// Pagination continues from the
    /// end of the previous response that returned the `NextToken` value. This value
    /// is `null` when
    /// there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListConfigurationPoliciesOutput = struct {
    /// Provides metadata for each of your configuration policies.
    configuration_policy_summaries: ?[]const ConfigurationPolicySummary = null,

    /// The `NextToken` value to include in the next `ListConfigurationPolicies`
    /// request. When the
    /// results of a `ListConfigurationPolicies` request exceed `MaxResults`, this
    /// value can be used to
    /// retrieve the next page of results. This value is `null` when there are no
    /// more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_policy_summaries = "ConfigurationPolicySummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConfigurationPoliciesInput, options: CallOptions) !ListConfigurationPoliciesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListConfigurationPoliciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/configurationPolicy/list";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConfigurationPoliciesOutput {
    const result: ListConfigurationPoliciesOutput = try aws.json.parseJsonObject(
        ListConfigurationPoliciesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
