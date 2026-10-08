const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleFirewallType = @import("rule_firewall_type.zig").RuleFirewallType;
const RuleType = @import("rule_type.zig").RuleType;
const WAFConfigDataType = @import("waf_config_data_type.zig").WAFConfigDataType;

pub const GenerateRuleConfigurationInput = struct {
    /// A unique, case-sensitive token that you provide to ensure that the operation
    /// completes no more than one time. If you retry a request with the same client
    /// token and the same parameters, the service returns the result of the
    /// original successful request.
    client_token: ?[]const u8 = null,

    /// An existing configuration to edit, as a JSON string. When you provide this
    /// value, the operation edits the configuration. When you omit it, the
    /// operation generates a new configuration.
    current_configuration: ?[]const u8 = null,

    /// A natural-language description of the configuration that you want to
    /// generate.
    prompt: []const u8,

    /// The firewall type of the rule.
    rule_firewall_type: RuleFirewallType,

    /// The type of the rule. `CONFIGURATION` rules contain firewall settings, and
    /// `INSPECTION` rules contain rule groups.
    rule_type: RuleType,

    /// For AWS WAF configuration rules, the specific AWS WAF configuration variant
    /// to generate. This is optional; if you omit it, the service selects the
    /// variant.
    waf_config_data_type: ?WAFConfigDataType = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .current_configuration = "currentConfiguration",
        .prompt = "prompt",
        .rule_firewall_type = "ruleFirewallType",
        .rule_type = "ruleType",
        .waf_config_data_type = "wafConfigDataType",
    };
};

pub const GenerateRuleConfigurationOutput = struct {
    /// The generated configuration, as a JSON string. You can use this value in the
    /// `configuration` field of a rule.
    configuration: []const u8,

    /// Reserved for a future human-readable description of the generated
    /// configuration. This field is currently not populated.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .description = "description",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateRuleConfigurationInput, options: CallOptions) !GenerateRuleConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "network-security-manager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateRuleConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("network-security-manager", "Network Security Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GenerateRuleConfiguration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.current_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"currentConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"prompt\":");
    try aws.json.writeValue(@TypeOf(input.prompt), input.prompt, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ruleFirewallType\":");
    try aws.json.writeValue(@TypeOf(input.rule_firewall_type), input.rule_firewall_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ruleType\":");
    try aws.json.writeValue(@TypeOf(input.rule_type), input.rule_type, allocator, &body_buf);
    has_prev = true;
    if (input.waf_config_data_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"wafConfigDataType\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateRuleConfigurationOutput {
    const result: GenerateRuleConfigurationOutput = try aws.json.parseJsonObject(
        GenerateRuleConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
