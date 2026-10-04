const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssociationFilters = @import("association_filters.zig").AssociationFilters;
const ConfigurationPolicyAssociationSummary = @import("configuration_policy_association_summary.zig").ConfigurationPolicyAssociationSummary;

pub const ListConfigurationPolicyAssociationsInput = struct {
    /// Options for filtering the `ListConfigurationPolicyAssociations` response.
    /// You can filter by the Amazon Resource Name (ARN) or
    /// universally unique identifier (UUID) of a configuration, `AssociationType`,
    /// or `AssociationStatus`.
    filters: ?AssociationFilters = null,

    /// The maximum number of results that's returned by `ListConfigurationPolicies`
    /// in each page of the response.
    /// When this parameter is used, `ListConfigurationPolicyAssociations` returns
    /// the specified number of results
    /// in a single page and a `NextToken` response element. You can see the
    /// remaining results of the initial
    /// request by sending another `ListConfigurationPolicyAssociations` request
    /// with the returned `NextToken`
    /// value. A valid range for `MaxResults` is between 1 and 100.
    max_results: ?i32 = null,

    /// The `NextToken` value that's returned from a previous paginated
    /// `ListConfigurationPolicyAssociations`
    /// request where `MaxResults` was used but the results exceeded the value of
    /// that parameter. Pagination
    /// continues from the end of the previous response that returned the
    /// `NextToken` value. This value is `null`
    /// when there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListConfigurationPolicyAssociationsOutput = struct {
    /// An object that contains the details of each configuration policy association
    /// that’s returned in a
    /// `ListConfigurationPolicyAssociations` request.
    configuration_policy_association_summaries: ?[]const ConfigurationPolicyAssociationSummary = null,

    /// The `NextToken` value to include in the next
    /// `ListConfigurationPolicyAssociations` request. When
    /// the results of a `ListConfigurationPolicyAssociations` request exceed
    /// `MaxResults`, this value
    /// can be used to retrieve the next page of results. This value is `null` when
    /// there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_policy_association_summaries = "ConfigurationPolicyAssociationSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConfigurationPolicyAssociationsInput, options: CallOptions) !ListConfigurationPolicyAssociationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListConfigurationPolicyAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/configurationPolicyAssociation/list";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConfigurationPolicyAssociationsOutput {
    const result: ListConfigurationPolicyAssociationsOutput = try aws.json.parseJsonObject(
        ListConfigurationPolicyAssociationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
