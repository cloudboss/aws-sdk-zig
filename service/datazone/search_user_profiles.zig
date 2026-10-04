const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserSearchType = @import("user_search_type.zig").UserSearchType;
const UserProfileSummary = @import("user_profile_summary.zig").UserProfileSummary;

pub const SearchUserProfilesInput = struct {
    /// The identifier of the Amazon DataZone domain in which you want to search
    /// user profiles.
    domain_identifier: []const u8,

    /// The maximum number of results to return in a single call to
    /// `SearchUserProfiles`. When the number of results to be listed is greater
    /// than the value of `MaxResults`, the response contains a `NextToken` value
    /// that you can use in a subsequent call to `SearchUserProfiles` to list the
    /// next set of results.
    max_results: ?i32 = null,

    /// When the number of results is greater than the default value for the
    /// `MaxResults` parameter, or if you explicitly specify a value for
    /// `MaxResults` that is less than the number of results, the response includes
    /// a pagination token named `NextToken`. You can specify this `NextToken` value
    /// in a subsequent call to `SearchUserProfiles` to list the next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// Specifies the text for which to search.
    search_text: ?[]const u8 = null,

    /// Specifies the user type for the `SearchUserProfiles` action.
    user_type: UserSearchType,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .search_text = "searchText",
        .user_type = "userType",
    };
};

pub const SearchUserProfilesOutput = struct {
    /// The results of the `SearchUserProfiles` action.
    items: ?[]const UserProfileSummary = null,

    /// When the number of results is greater than the default value for the
    /// `MaxResults` parameter, or if you explicitly specify a value for
    /// `MaxResults` that is less than the number of results, the response includes
    /// a pagination token named `NextToken`. You can specify this `NextToken` value
    /// in a subsequent call to `SearchUserProfiles` to list the next set of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchUserProfilesInput, options: CallOptions) !SearchUserProfilesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchUserProfilesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/search-user-profiles");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    if (input.search_text) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"searchText\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"userType\":");
    try aws.json.writeValue(@TypeOf(input.user_type), input.user_type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchUserProfilesOutput {
    var result: SearchUserProfilesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SearchUserProfilesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
