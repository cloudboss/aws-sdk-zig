const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortFieldProject = @import("sort_field_project.zig").SortFieldProject;
const SortOrder = @import("sort_order.zig").SortOrder;
const ProjectProfileSummary = @import("project_profile_summary.zig").ProjectProfileSummary;

pub const ListProjectProfilesInput = struct {
    /// The ID of the domain where you want to list project profiles.
    domain_identifier: []const u8,

    /// The maximum number of project profiles to return in a single call to
    /// ListProjectProfiles. When the number of project profiles to be listed is
    /// greater than the value of MaxResults, the response contains a NextToken
    /// value that you can use in a subsequent call to ListProjectProfiles to list
    /// the next set of project profiles.
    max_results: ?i32 = null,

    /// The name of a project profile.
    name: ?[]const u8 = null,

    /// When the number of project profiles is greater than the default value for
    /// the MaxResults parameter, or if you explicitly specify a value for
    /// MaxResults that is less than the number of project profiles, the response
    /// includes a pagination token named NextToken. You can specify this NextToken
    /// value in a subsequent call to ListProjectProfiles to list the next set of
    /// project profiles.
    next_token: ?[]const u8 = null,

    /// Specifies by what to sort project profiles.
    sort_by: ?SortFieldProject = null,

    /// Specifies the sort order of the project profiles.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .max_results = "maxResults",
        .name = "name",
        .next_token = "nextToken",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};

pub const ListProjectProfilesOutput = struct {
    /// The results of the ListProjectProfiles action.
    items: ?[]const ProjectProfileSummary = null,

    /// When the number of project profiles is greater than the default value for
    /// the MaxResults parameter, or if you explicitly specify a value for
    /// MaxResults that is less than the number of project profiles, the response
    /// includes a pagination token named NextToken. You can specify this NextToken
    /// value in a subsequent call to ListProjectProfiles to list the next set of
    /// project profiles.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListProjectProfilesInput, options: CallOptions) !ListProjectProfilesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListProjectProfilesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/project-profiles");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "name=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.sort_by) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "sortBy=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.sort_order) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "sortOrder=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListProjectProfilesOutput {
    var result: ListProjectProfilesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListProjectProfilesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
