const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DiscoveryIntegrationStatus = @import("discovery_integration_status.zig").DiscoveryIntegrationStatus;
const AccountJiraConfigurationOutput = @import("account_jira_configuration_output.zig").AccountJiraConfigurationOutput;
const OrganizationSharingStatus = @import("organization_sharing_status.zig").OrganizationSharingStatus;

pub const GetGlobalSettingsInput = struct {};

pub const GetGlobalSettingsOutput = struct {
    /// Discovery integration status.
    discovery_integration_status: ?DiscoveryIntegrationStatus = null,

    /// Jira configuration status.
    jira_configuration: ?AccountJiraConfigurationOutput = null,

    /// Amazon Web Services Organizations sharing status.
    organization_sharing_status: ?OrganizationSharingStatus = null,

    pub const json_field_names = .{
        .discovery_integration_status = "DiscoveryIntegrationStatus",
        .jira_configuration = "JiraConfiguration",
        .organization_sharing_status = "OrganizationSharingStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGlobalSettingsInput, options: CallOptions) !GetGlobalSettingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGlobalSettingsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/global-settings";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGlobalSettingsOutput {
    var result: GetGlobalSettingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetGlobalSettingsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
