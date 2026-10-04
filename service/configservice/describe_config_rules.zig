const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DescribeConfigRulesFilters = @import("describe_config_rules_filters.zig").DescribeConfigRulesFilters;
const ConfigRule = @import("config_rule.zig").ConfigRule;

pub const DescribeConfigRulesInput = struct {
    /// The names of the Config rules for which you want details.
    /// If you do not specify any names, Config returns details for all
    /// your rules.
    config_rule_names: ?[]const []const u8 = null,

    /// Returns a list of Detective or Proactive Config rules. By default, this API
    /// returns an unfiltered list. For more information on Detective or Proactive
    /// Config rules,
    /// see [
    /// **Evaluation Mode**
    /// ](https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config-rules.html) in the *Config Developer Guide*.
    filters: ?DescribeConfigRulesFilters = null,

    /// The `nextToken` string returned on a previous page
    /// that you use to get the next page of results in a paginated
    /// response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .config_rule_names = "ConfigRuleNames",
        .filters = "Filters",
        .next_token = "NextToken",
    };
};

pub const DescribeConfigRulesOutput = struct {
    /// The details about your Config rules.
    config_rules: ?[]const ConfigRule = null,

    /// The string that you use in a subsequent request to get the next
    /// page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .config_rules = "ConfigRules",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConfigRulesInput, options: CallOptions) !DescribeConfigRulesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConfigRulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.DescribeConfigRules");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConfigRulesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeConfigRulesOutput, body, allocator);
}
