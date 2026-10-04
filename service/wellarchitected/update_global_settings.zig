const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DiscoveryIntegrationStatus = @import("discovery_integration_status.zig").DiscoveryIntegrationStatus;
const AccountJiraConfigurationInput = @import("account_jira_configuration_input.zig").AccountJiraConfigurationInput;
const OrganizationSharingStatus = @import("organization_sharing_status.zig").OrganizationSharingStatus;

pub const UpdateGlobalSettingsInput = struct {
    /// The status of discovery support settings.
    discovery_integration_status: ?DiscoveryIntegrationStatus = null,

    /// The status of Jira integration settings.
    jira_configuration: ?AccountJiraConfigurationInput = null,

    /// The status of organization sharing settings.
    organization_sharing_status: ?OrganizationSharingStatus = null,

    pub const json_field_names = .{
        .discovery_integration_status = "DiscoveryIntegrationStatus",
        .jira_configuration = "JiraConfiguration",
        .organization_sharing_status = "OrganizationSharingStatus",
    };
};

pub const UpdateGlobalSettingsOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGlobalSettingsInput, options: CallOptions) !UpdateGlobalSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wellarchitected", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGlobalSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/global-settings";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.discovery_integration_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DiscoveryIntegrationStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.jira_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"JiraConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.organization_sharing_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OrganizationSharingStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGlobalSettingsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateGlobalSettingsOutput = .{};

    return result;
}
