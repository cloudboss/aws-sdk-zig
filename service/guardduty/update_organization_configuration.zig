const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AutoEnableMembers = @import("auto_enable_members.zig").AutoEnableMembers;
const OrganizationDataSourceConfigurations = @import("organization_data_source_configurations.zig").OrganizationDataSourceConfigurations;
const OrganizationFeatureConfiguration = @import("organization_feature_configuration.zig").OrganizationFeatureConfiguration;

pub const UpdateOrganizationConfigurationInput = struct {
    /// Represents whether to automatically enable member accounts in the
    /// organization. This
    /// applies to only new member accounts, not the existing member accounts. When
    /// a new account joins the organization,
    /// the chosen features will be enabled for them by default.
    ///
    /// Even though this is still supported, we recommend using
    /// `AutoEnableOrganizationMembers` to achieve the similar results. You must
    /// provide a
    /// value for either `autoEnableOrganizationMembers` or `autoEnable`.
    auto_enable: ?bool = null,

    /// Indicates the auto-enablement configuration of GuardDuty for the member
    /// accounts in the
    /// organization. You must provide a value for either
    /// `autoEnableOrganizationMembers` or `autoEnable`.
    ///
    /// Use one of the
    /// following configuration values for `autoEnableOrganizationMembers`:
    ///
    /// * `NEW`: Indicates that when a new account joins the organization, they will
    /// have GuardDuty enabled automatically.
    ///
    /// * `ALL`: Indicates that all accounts in the organization have GuardDuty
    /// enabled automatically. This includes `NEW` accounts that join the
    /// organization
    /// and accounts that may have been suspended or removed from the organization
    /// in
    /// GuardDuty.
    ///
    /// It may take up to 24 hours to update the configuration for all the member
    /// accounts.
    ///
    /// * `NONE`: Indicates that GuardDuty will not be automatically enabled for any
    /// account in the organization. The administrator must manage GuardDuty for
    /// each account in the organization individually.
    ///
    /// When you update the auto-enable setting from `ALL` or `NEW` to
    /// `NONE`, this action doesn't disable the corresponding option for your
    /// existing accounts. This
    /// configuration will apply to the new accounts that join the organization.
    /// After you update the auto-enable settings,
    /// no new account will have the corresponding option as enabled.
    auto_enable_organization_members: ?AutoEnableMembers = null,

    /// Describes which data sources will be updated.
    data_sources: ?OrganizationDataSourceConfigurations = null,

    /// The ID of the detector that configures the delegated administrator.
    ///
    /// To find the `detectorId` in the current Region, see the
    /// Settings page in the GuardDuty console, or run the
    /// [ListDetectors](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_ListDetectors.html) API.
    detector_id: []const u8,

    /// A list of features that will be configured for the organization.
    features: ?[]const OrganizationFeatureConfiguration = null,

    pub const json_field_names = .{
        .auto_enable = "AutoEnable",
        .auto_enable_organization_members = "AutoEnableOrganizationMembers",
        .data_sources = "DataSources",
        .detector_id = "DetectorId",
        .features = "Features",
    };
};

pub const UpdateOrganizationConfigurationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateOrganizationConfigurationInput, options: CallOptions) !UpdateOrganizationConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateOrganizationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/detector/");
    try path_buf.appendSlice(allocator, input.detector_id);
    try path_buf.appendSlice(allocator, "/admin");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.auto_enable) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AutoEnable\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.auto_enable_organization_members) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AutoEnableOrganizationMembers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.data_sources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DataSources\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.features) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Features\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateOrganizationConfigurationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateOrganizationConfigurationOutput = .{};

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
