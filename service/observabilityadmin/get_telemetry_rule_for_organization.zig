const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegionStatus = @import("region_status.zig").RegionStatus;
const TelemetryRule = @import("telemetry_rule.zig").TelemetryRule;

pub const GetTelemetryRuleForOrganizationInput = struct {
    /// The identifier (name or ARN) of the organization telemetry rule to retrieve.
    rule_identifier: []const u8,

    pub const json_field_names = .{
        .rule_identifier = "RuleIdentifier",
    };
};

pub const GetTelemetryRuleForOrganizationOutput = struct {
    /// The timestamp when the organization telemetry rule was created.
    created_time_stamp: ?i64 = null,

    /// The Amazon Web Services Region where the organization telemetry rule was
    /// originally created. For replicated rules in spoke regions, this indicates
    /// the region that manages the rule. For rules created without multi-region
    /// scope, this field is not present.
    home_region: ?[]const u8 = null,

    /// Indicates whether this organization telemetry rule is a replica that was
    /// created in this region through multi-region fan-out from the home region.
    /// Replicated rules cannot be directly updated or deleted in the spoke region.
    /// To modify a replicated rule, make changes in the home region.
    is_replicated: ?bool = null,

    /// The timestamp when the organization telemetry rule was last updated.
    last_update_time_stamp: ?i64 = null,

    /// A list of per-region replication statuses for the organization telemetry
    /// rule. Each entry indicates the replication status of the rule in a specific
    /// spoke region. This field is only present for rules created with multi-region
    /// scope.
    region_statuses: ?[]const RegionStatus = null,

    /// The Amazon Resource Name (ARN) of the organization telemetry rule.
    rule_arn: ?[]const u8 = null,

    /// The name of the organization telemetry rule.
    rule_name: ?[]const u8 = null,

    /// The configuration details of the organization telemetry rule.
    telemetry_rule: ?TelemetryRule = null,

    pub const json_field_names = .{
        .created_time_stamp = "CreatedTimeStamp",
        .home_region = "HomeRegion",
        .is_replicated = "IsReplicated",
        .last_update_time_stamp = "LastUpdateTimeStamp",
        .region_statuses = "RegionStatuses",
        .rule_arn = "RuleArn",
        .rule_name = "RuleName",
        .telemetry_rule = "TelemetryRule",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTelemetryRuleForOrganizationInput, options: CallOptions) !GetTelemetryRuleForOrganizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "observabilityadmin", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTelemetryRuleForOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("observabilityadmin", "ObservabilityAdmin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetTelemetryRuleForOrganization";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RuleIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.rule_identifier), input.rule_identifier, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTelemetryRuleForOrganizationOutput {
    const result: GetTelemetryRuleForOrganizationOutput = try aws.json.parseJsonObject(
        GetTelemetryRuleForOrganizationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
