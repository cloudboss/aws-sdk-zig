const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoEnableStandards = @import("auto_enable_standards.zig").AutoEnableStandards;
const OrganizationConfiguration = @import("organization_configuration.zig").OrganizationConfiguration;

pub const UpdateOrganizationConfigurationInput = struct {
    /// Whether to automatically enable Security Hub CSPM in new member accounts
    /// when they join the organization.
    ///
    /// If set to `true`, then Security Hub CSPM is automatically enabled in new
    /// accounts. If set to `false`,
    /// then Security Hub CSPM isn't enabled in new accounts automatically. The
    /// default value is `false`.
    ///
    /// If the `ConfigurationType` of your organization is set to `CENTRAL`, then
    /// this field is set
    /// to `false` and can't be changed in the home Region and linked Regions.
    /// However, in that case, the delegated administrator can create a
    /// configuration
    /// policy in which Security Hub CSPM is enabled and associate the policy with
    /// new organization accounts.
    auto_enable: bool,

    /// Whether to automatically enable Security Hub CSPM [default
    /// standards](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-standards-enable-disable.html)
    /// in new member accounts when they join the organization.
    ///
    /// The default value of this parameter is equal to `DEFAULT`.
    ///
    /// If equal to `DEFAULT`, then Security Hub CSPM default standards are
    /// automatically enabled for new member
    /// accounts. If equal to `NONE`, then default standards are not automatically
    /// enabled for new member
    /// accounts.
    ///
    /// If the `ConfigurationType` of your organization is set to `CENTRAL`, then
    /// this field is set
    /// to `NONE` and can't be changed in the home Region and linked Regions.
    /// However, in that case, the delegated administrator can create a
    /// configuration
    /// policy in which specific security standards are enabled and associate the
    /// policy with new organization accounts.
    auto_enable_standards: ?AutoEnableStandards = null,

    organization_configuration: ?OrganizationConfiguration = null,

    pub const json_field_names = .{
        .auto_enable = "AutoEnable",
        .auto_enable_standards = "AutoEnableStandards",
        .organization_configuration = "OrganizationConfiguration",
    };
};

pub const UpdateOrganizationConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateOrganizationConfigurationInput, options: CallOptions) !UpdateOrganizationConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateOrganizationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/organization/configuration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AutoEnable\":");
    try aws.json.writeValue(@TypeOf(input.auto_enable), input.auto_enable, allocator, &body_buf);
    has_prev = true;
    if (input.auto_enable_standards) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AutoEnableStandards\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.organization_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OrganizationConfiguration\":");
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
