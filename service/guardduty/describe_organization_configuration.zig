const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AutoEnableMembers = @import("auto_enable_members.zig").AutoEnableMembers;
const OrganizationDataSourceConfigurationsResult = @import("organization_data_source_configurations_result.zig").OrganizationDataSourceConfigurationsResult;
const OrganizationFeatureConfigurationResult = @import("organization_feature_configuration_result.zig").OrganizationFeatureConfigurationResult;

pub const DescribeOrganizationConfigurationInput = struct {
    /// The detector ID of the delegated administrator for which you need to
    /// retrieve the information.
    ///
    /// To find the `detectorId` in the current Region, see the
    /// Settings page in the GuardDuty console, or run the
    /// [ListDetectors](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_ListDetectors.html) API.
    detector_id: []const u8,

    /// You can use this parameter to indicate the maximum number of items that you
    /// want in the
    /// response.
    max_results: ?i32 = null,

    /// You can use this parameter when paginating results. Set the value of this
    /// parameter to
    /// null on your first call to the list action. For subsequent calls to the
    /// action, fill
    /// `nextToken` in the request with the value of `NextToken` from the
    /// previous response to continue listing data.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .detector_id = "DetectorId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeOrganizationConfigurationOutput = struct {
    /// Indicates whether GuardDuty is automatically enabled for accounts added to
    /// the
    /// organization.
    ///
    /// Even though this is still supported, we recommend using
    /// `AutoEnableOrganizationMembers` to achieve the similar results.
    auto_enable: ?bool = null,

    /// Indicates the auto-enablement configuration of GuardDuty or any of the
    /// corresponding protection plans for the member accounts in the
    /// organization.
    ///
    /// * `NEW`: Indicates that when a new account joins the organization, they will
    /// have GuardDuty or any of the corresponding protection plans enabled
    /// automatically.
    ///
    /// * `ALL`: Indicates that all accounts in the organization have GuardDuty and
    ///   any of the corresponding
    /// protection plans enabled automatically. This includes `NEW` accounts that
    /// join the organization
    /// and accounts that may have been suspended or removed from the organization
    /// in
    /// GuardDuty.
    ///
    /// * `NONE`: Indicates that GuardDuty or any of the corresponding protection
    ///   plans
    /// will not be automatically enabled for any
    /// account in the organization. The administrator must manage GuardDuty for
    /// each account in
    /// the organization individually.
    ///
    /// When you update the auto-enable setting from `ALL` or `NEW` to
    /// `NONE`, this action doesn't disable the corresponding option for your
    /// existing accounts. This
    /// configuration will apply to the new accounts that join the organization.
    /// After you update the auto-enable settings,
    /// no new account will have the corresponding option as enabled.
    auto_enable_organization_members: ?AutoEnableMembers = null,

    /// Describes which data sources are enabled automatically for member accounts.
    data_sources: ?OrganizationDataSourceConfigurationsResult = null,

    /// A list of features that are configured for this organization.
    features: ?[]const OrganizationFeatureConfigurationResult = null,

    /// Indicates whether the maximum number of allowed member accounts are already
    /// associated
    /// with the delegated administrator account for your organization.
    member_account_limit_reached: bool,

    /// The pagination parameter to be used on the next list operation to retrieve
    /// more
    /// items.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .auto_enable = "AutoEnable",
        .auto_enable_organization_members = "AutoEnableOrganizationMembers",
        .data_sources = "DataSources",
        .features = "Features",
        .member_account_limit_reached = "MemberAccountLimitReached",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeOrganizationConfigurationInput, options: Options) !DescribeOrganizationConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "guardduty");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeOrganizationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/detector/");
    try path_buf.appendSlice(allocator, input.detector_id);
    try path_buf.appendSlice(allocator, "/admin");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
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
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeOrganizationConfigurationOutput {
    var result: DescribeOrganizationConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeOrganizationConfigurationOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
