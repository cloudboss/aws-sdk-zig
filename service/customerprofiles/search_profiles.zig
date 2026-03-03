const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AdditionalSearchKey = @import("additional_search_key.zig").AdditionalSearchKey;
const logicalOperator = @import("logical_operator.zig").logicalOperator;
const Profile = @import("profile.zig").Profile;

pub const SearchProfilesInput = struct {
    /// A list of `AdditionalSearchKey` objects that are each searchable identifiers
    /// of a profile. Each `AdditionalSearchKey` object contains a `KeyName`
    /// and a list of `Values` associated with that specific key (i.e., a
    /// key-value(s)
    /// pair). These additional search keys will be used in conjunction with the
    /// `LogicalOperator` and the required `KeyName` and
    /// `Values` parameters to search for profiles that satisfy the search criteria.
    additional_search_keys: ?[]const AdditionalSearchKey = null,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// A searchable identifier of a customer profile. The predefined keys you can
    /// use to search include: _account, _profileId,
    /// _assetId, _caseId, _orderId, _fullName, _phone, _email, _ctrContactId,
    /// _marketoLeadId,
    /// _salesforceAccountId, _salesforceContactId, _salesforceAssetId,
    /// _zendeskUserId,
    /// _zendeskExternalId, _zendeskTicketId, _serviceNowSystemId,
    /// _serviceNowIncidentId,
    /// _segmentUserId, _shopifyCustomerId, _shopifyOrderId.
    key_name: []const u8,

    /// Relationship between all specified search keys that will be used to search
    /// for profiles.
    /// This includes the required `KeyName` and `Values` parameters as well
    /// as any key-value(s) pairs specified in the `AdditionalSearchKeys` list.
    ///
    /// This parameter influences which profiles will be returned in the response in
    /// the
    /// following manner:
    ///
    /// * `AND` - The response only includes profiles that match all of the
    /// search keys.
    ///
    /// * `OR` - The response includes profiles that match at least one of the
    /// search keys.
    ///
    /// The `OR` relationship is the default behavior if this parameter is not
    /// included in the request.
    logical_operator: ?logicalOperator = null,

    /// The maximum number of objects returned per page.
    ///
    /// The default is 20 if this parameter is not included in the request.
    max_results: ?i32 = null,

    /// The pagination token from the previous SearchProfiles API call.
    next_token: ?[]const u8 = null,

    /// A list of key values.
    values: []const []const u8,

    pub const json_field_names = .{
        .additional_search_keys = "AdditionalSearchKeys",
        .domain_name = "DomainName",
        .key_name = "KeyName",
        .logical_operator = "LogicalOperator",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .values = "Values",
    };
};

pub const SearchProfilesOutput = struct {
    /// The list of Profiles matching the search criteria.
    items: ?[]const Profile = null,

    /// The pagination token from the previous SearchProfiles API call.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "Items",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchProfilesInput, options: Options) !SearchProfilesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchProfilesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("customerprofiles", "Customer Profiles", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/profiles/search");
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

    if (input.additional_search_keys) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AdditionalSearchKeys\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"KeyName\":");
    try aws.json.writeValue(@TypeOf(input.key_name), input.key_name, allocator, &body_buf);
    has_prev = true;
    if (input.logical_operator) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LogicalOperator\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Values\":");
    try aws.json.writeValue(@TypeOf(input.values), input.values, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchProfilesOutput {
    var result: SearchProfilesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SearchProfilesOutput, body, allocator);
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
