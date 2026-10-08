const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoEnableMode = @import("auto_enable_mode.zig").AutoEnableMode;
const AutomatedDiscoveryStatus = @import("automated_discovery_status.zig").AutomatedDiscoveryStatus;

pub const UpdateAutomatedDiscoveryConfigurationInput = struct {
    /// Specifies whether to automatically enable automated sensitive data discovery
    /// for accounts in the organization. Valid values are: ALL (default), enable it
    /// for all existing accounts and new member accounts; NEW, enable it only for
    /// new member accounts; and, NONE, don't enable it for any accounts.
    ///
    /// If you specify NEW or NONE, automated sensitive data discovery continues to
    /// be enabled for any existing accounts that it's currently enabled for. To
    /// enable or disable it for individual member accounts, specify NEW or NONE,
    /// and then enable or disable it for each account by using the
    /// BatchUpdateAutomatedDiscoveryAccounts operation.
    auto_enable_organization_members: ?AutoEnableMode = null,

    /// The new status of automated sensitive data discovery for the organization or
    /// account. Valid values are: ENABLED, start or resume all automated sensitive
    /// data discovery activities; and, DISABLED, stop performing all automated
    /// sensitive data discovery activities.
    ///
    /// If you specify DISABLED for an administrator account, you also disable
    /// automated sensitive data discovery for all member accounts in the
    /// organization.
    status: AutomatedDiscoveryStatus,

    pub const json_field_names = .{
        .auto_enable_organization_members = "autoEnableOrganizationMembers",
        .status = "status",
    };
};

pub const UpdateAutomatedDiscoveryConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAutomatedDiscoveryConfigurationInput, options: CallOptions) !UpdateAutomatedDiscoveryConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAutomatedDiscoveryConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/automated-discovery/configuration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.auto_enable_organization_members) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"autoEnableOrganizationMembers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"status\":");
    try aws.json.writeValue(@TypeOf(input.status), input.status, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAutomatedDiscoveryConfigurationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateAutomatedDiscoveryConfigurationOutput = .{};

    return result;
}
