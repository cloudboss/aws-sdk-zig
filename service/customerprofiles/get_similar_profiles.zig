const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const MatchType = @import("match_type.zig").MatchType;

pub const GetSimilarProfilesInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// Specify the type of matching to get similar profiles for.
    match_type: MatchType,

    /// The maximum number of objects returned per page.
    max_results: ?i32 = null,

    /// The pagination token from the previous `GetSimilarProfiles` API call.
    next_token: ?[]const u8 = null,

    /// The string indicating the search key to be used.
    search_key: []const u8,

    /// The string based on `SearchKey` to be searched for similar profiles.
    search_value: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .match_type = "MatchType",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .search_key = "SearchKey",
        .search_value = "SearchValue",
    };
};

pub const GetSimilarProfilesOutput = struct {
    /// It only has value when the `MatchType` is `ML_BASED_MATCHING`.A
    /// number between 0 and 1, where a higher score means higher similarity.
    /// Examining match
    /// confidence scores lets you distinguish between groups of similar records in
    /// which the
    /// system is highly confident (which you may decide to merge), groups of
    /// similar records about
    /// which the system is uncertain (which you may decide to have reviewed by a
    /// human), and
    /// groups of similar records that the system deems to be unlikely (which you
    /// may decide to
    /// reject). Given confidence scores vary as per the data input, it should not
    /// be used as an
    /// absolute measure of matching quality.
    confidence_score: ?f64 = null,

    /// The string `matchId` that the similar profiles belong to.
    match_id: ?[]const u8 = null,

    /// Specify the type of matching to get similar profiles for.
    match_type: ?MatchType = null,

    /// The pagination token from the previous `GetSimilarProfiles` API call.
    next_token: ?[]const u8 = null,

    /// Set of `profileId`s that belong to the same matching group.
    profile_ids: ?[]const []const u8 = null,

    /// The integer rule level that the profiles matched on.
    rule_level: ?i32 = null,

    pub const json_field_names = .{
        .confidence_score = "ConfidenceScore",
        .match_id = "MatchId",
        .match_type = "MatchType",
        .next_token = "NextToken",
        .profile_ids = "ProfileIds",
        .rule_level = "RuleLevel",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSimilarProfilesInput, options: CallOptions) !GetSimilarProfilesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "customerprofiles");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetSimilarProfilesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("customerprofiles", "Customer Profiles", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/matches");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "max-results=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "next-token=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MatchType\":");
    try aws.json.writeValue(@TypeOf(input.match_type), input.match_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SearchKey\":");
    try aws.json.writeValue(@TypeOf(input.search_key), input.search_key, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SearchValue\":");
    try aws.json.writeValue(@TypeOf(input.search_value), input.search_value, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSimilarProfilesOutput {
    var result: GetSimilarProfilesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSimilarProfilesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
