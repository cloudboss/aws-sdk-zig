const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoEnableMembers = @import("auto_enable_members.zig").AutoEnableMembers;
const OrganizationDataSourceConfigurations = @import("organization_data_source_configurations.zig").OrganizationDataSourceConfigurations;
const OrganizationFeatureConfiguration = @import("organization_feature_configuration.zig").OrganizationFeatureConfiguration;

pub const UpdateOrganizationConfigurationInput = struct {
    /// Represents whether to automatically enable member accounts in the
    /// organization. This applies to only new member accounts, not the existing
    /// member accounts. When a new account joins the organization, the chosen
    /// features will be enabled for them by default.
    ///
    /// Even though this is still supported, we recommend using
    /// `AutoEnableOrganizationMembers` to achieve the similar results. You must
    /// provide a value for either `autoEnableOrganizationMembers` or `autoEnable`.
    auto_enable: ?bool = null,

    /// Indicates the auto-enablement configuration of GuardDuty for the member
    /// accounts in the organization. You must provide a value for either
    /// `autoEnableOrganizationMembers` or `autoEnable`.
    ///
    /// Use one of the following configuration values for
    /// `autoEnableOrganizationMembers`:
    ///
    /// * `NEW`: Indicates that when a new account joins the organization, they will
    ///   have GuardDuty enabled automatically.
    /// * `ALL`: Indicates that all accounts in the organization have GuardDuty
    ///   enabled automatically. This includes `NEW` accounts that join the
    ///   organization and accounts that may have been suspended or removed from the
    ///   organization in GuardDuty.
    ///
    /// It may take up to 24 hours to update the configuration for all the member
    /// accounts.
    /// * `NONE`: Indicates that GuardDuty will not be automatically enabled for any
    ///   account in the organization. The administrator must manage GuardDuty for
    ///   each account in the organization individually.
    ///
    /// When you update the auto-enable setting from `ALL` or `NEW` to `NONE`, this
    /// action doesn't disable the corresponding option for your existing accounts.
    /// This configuration will apply to the new accounts that join the
    /// organization. After you update the auto-enable settings, no new account will
    /// have the corresponding option as enabled.
    auto_enable_organization_members: ?AutoEnableMembers = null,

    /// Describes which data sources will be updated.
    data_sources: ?OrganizationDataSourceConfigurations = null,

    /// The ID of the detector that configures the delegated administrator.
    ///
    /// To find the `detectorId` in the current Region, see the Settings page in the
    /// GuardDuty console, or run the
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

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "guardduty", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateOrganizationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/detector/");
    try path_buf.appendSlice(allocator, input.detector_id);
    try path_buf.appendSlice(allocator, "/admin");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
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
