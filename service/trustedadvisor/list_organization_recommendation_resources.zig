const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExclusionStatus = @import("exclusion_status.zig").ExclusionStatus;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;
const OrganizationRecommendationResourceSummary = @import("organization_recommendation_resource_summary.zig").OrganizationRecommendationResourceSummary;

pub const ListOrganizationRecommendationResourcesInput = struct {
    /// An account affected by this organization recommendation
    affected_account_id: ?[]const u8 = null,

    /// The exclusion status of the resource
    exclusion_status: ?ExclusionStatus = null,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The AWS Organization organization's Recommendation identifier
    organization_recommendation_identifier: []const u8,

    /// The AWS Region code of the resource
    region_code: ?[]const u8 = null,

    /// The status of the resource
    status: ?ResourceStatus = null,

    pub const json_field_names = .{
        .affected_account_id = "affectedAccountId",
        .exclusion_status = "exclusionStatus",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .organization_recommendation_identifier = "organizationRecommendationIdentifier",
        .region_code = "regionCode",
        .status = "status",
    };
};

pub const ListOrganizationRecommendationResourcesOutput = struct {
    /// The token for the next set of results. Use the value returned in the
    /// previous response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// A list of Recommendation Resources
    organization_recommendation_resource_summaries: ?[]const OrganizationRecommendationResourceSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .organization_recommendation_resource_summaries = "organizationRecommendationResourceSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListOrganizationRecommendationResourcesInput, options: CallOptions) !ListOrganizationRecommendationResourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "trustedadvisor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListOrganizationRecommendationResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("trustedadvisor", "TrustedAdvisor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/organization-recommendations/");
    try path_buf.appendSlice(allocator, input.organization_recommendation_identifier);
    try path_buf.appendSlice(allocator, "/resources");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.affected_account_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "affectedAccountId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.exclusion_status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "exclusionStatus=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.region_code) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "regionCode=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListOrganizationRecommendationResourcesOutput {
    const result: ListOrganizationRecommendationResourcesOutput = try aws.json.parseJsonObject(
        ListOrganizationRecommendationResourcesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
