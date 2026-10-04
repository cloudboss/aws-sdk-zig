const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoEnableMode = @import("auto_enable_mode.zig").AutoEnableMode;
const AutomatedDiscoveryStatus = @import("automated_discovery_status.zig").AutomatedDiscoveryStatus;

pub const GetAutomatedDiscoveryConfigurationInput = struct {
};

pub const GetAutomatedDiscoveryConfigurationOutput = struct {
    /// Specifies whether automated sensitive data discovery is enabled
    /// automatically for accounts in the organization. Possible values are: ALL,
    /// enable it for all existing accounts and new member accounts; NEW, enable it
    /// only for new member accounts; and, NONE, don't enable it for any accounts.
    auto_enable_organization_members: ?AutoEnableMode = null,

    /// The unique identifier for the classification scope that's used when
    /// performing automated sensitive data discovery. The classification scope
    /// specifies S3 buckets to exclude from analyses.
    classification_scope_id: ?[]const u8 = null,

    /// The date and time, in UTC and extended ISO 8601 format, when automated
    /// sensitive data discovery was most recently disabled. This value is null if
    /// automated sensitive data discovery is currently enabled.
    disabled_at: ?i64 = null,

    /// The date and time, in UTC and extended ISO 8601 format, when automated
    /// sensitive data discovery was initially enabled. This value is null if
    /// automated sensitive data discovery has never been enabled.
    first_enabled_at: ?i64 = null,

    /// The date and time, in UTC and extended ISO 8601 format, when the
    /// configuration settings or status of automated sensitive data discovery was
    /// most recently changed.
    last_updated_at: ?i64 = null,

    /// The unique identifier for the sensitivity inspection template that's used
    /// when performing automated sensitive data discovery. The template specifies
    /// which allow lists, custom data identifiers, and managed data identifiers to
    /// use when analyzing data.
    sensitivity_inspection_template_id: ?[]const u8 = null,

    /// The current status of automated sensitive data discovery for the
    /// organization or account. Possible values are: ENABLED, use the specified
    /// settings to perform automated sensitive data discovery activities; and,
    /// DISABLED, don't perform automated sensitive data discovery activities.
    status: ?AutomatedDiscoveryStatus = null,

    pub const json_field_names = .{
        .auto_enable_organization_members = "autoEnableOrganizationMembers",
        .classification_scope_id = "classificationScopeId",
        .disabled_at = "disabledAt",
        .first_enabled_at = "firstEnabledAt",
        .last_updated_at = "lastUpdatedAt",
        .sensitivity_inspection_template_id = "sensitivityInspectionTemplateId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAutomatedDiscoveryConfigurationInput, options: CallOptions) !GetAutomatedDiscoveryConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAutomatedDiscoveryConfigurationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/automated-discovery/configuration";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAutomatedDiscoveryConfigurationOutput {
    const result: GetAutomatedDiscoveryConfigurationOutput = try aws.json.parseJsonObject(
        GetAutomatedDiscoveryConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
