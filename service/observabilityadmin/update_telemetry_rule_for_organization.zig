const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TelemetryRule = @import("telemetry_rule.zig").TelemetryRule;

pub const UpdateTelemetryRuleForOrganizationInput = struct {
    /// The new configuration details for the organization telemetry rule, including
    /// resource type, telemetry type, and destination configuration.
    rule: TelemetryRule,

    /// The identifier (name or ARN) of the organization telemetry rule to update.
    rule_identifier: []const u8,

    pub const json_field_names = .{
        .rule = "Rule",
        .rule_identifier = "RuleIdentifier",
    };
};

pub const UpdateTelemetryRuleForOrganizationOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated organization telemetry rule.
    rule_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .rule_arn = "RuleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTelemetryRuleForOrganizationInput, options: CallOptions) !UpdateTelemetryRuleForOrganizationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTelemetryRuleForOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("observabilityadmin", "ObservabilityAdmin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateTelemetryRuleForOrganization";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Rule\":");
    try aws.json.writeValue(@TypeOf(input.rule), input.rule, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTelemetryRuleForOrganizationOutput {
    const result: UpdateTelemetryRuleForOrganizationOutput = try aws.json.parseJsonObject(
        UpdateTelemetryRuleForOrganizationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
