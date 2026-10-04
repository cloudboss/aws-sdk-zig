const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TelemetryRule = @import("telemetry_rule.zig").TelemetryRule;

pub const CreateTelemetryRuleForOrganizationInput = struct {
    /// The configuration details for the organization-wide telemetry rule,
    /// including the resource type, telemetry type, destination configuration, and
    /// selection criteria for which resources the rule applies to across the
    /// organization.
    rule: TelemetryRule,

    /// A unique name for the organization-wide telemetry rule being created.
    rule_name: []const u8,

    /// The key-value pairs to associate with the organization telemetry rule
    /// resource for categorization and management purposes.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .rule = "Rule",
        .rule_name = "RuleName",
        .tags = "Tags",
    };
};

pub const CreateTelemetryRuleForOrganizationOutput = struct {
    /// The Amazon Resource Name (ARN) of the created organization telemetry rule.
    rule_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .rule_arn = "RuleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTelemetryRuleForOrganizationInput, options: CallOptions) !CreateTelemetryRuleForOrganizationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTelemetryRuleForOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("observabilityadmin", "ObservabilityAdmin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateTelemetryRuleForOrganization";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Rule\":");
    try aws.json.writeValue(@TypeOf(input.rule), input.rule, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RuleName\":");
    try aws.json.writeValue(@TypeOf(input.rule_name), input.rule_name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTelemetryRuleForOrganizationOutput {
    var result: CreateTelemetryRuleForOrganizationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateTelemetryRuleForOrganizationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
