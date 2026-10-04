const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComplianceType = @import("compliance_type.zig").ComplianceType;
const ComplianceByConfigRule = @import("compliance_by_config_rule.zig").ComplianceByConfigRule;

pub const DescribeComplianceByConfigRuleInput = struct {
    /// Filters the results by compliance.
    compliance_types: ?[]const ComplianceType = null,

    /// Specify one or more Config rule names to filter the results
    /// by rule.
    config_rule_names: ?[]const []const u8 = null,

    /// The `nextToken` string returned on a previous page
    /// that you use to get the next page of results in a paginated
    /// response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .compliance_types = "ComplianceTypes",
        .config_rule_names = "ConfigRuleNames",
        .next_token = "NextToken",
    };
};

pub const DescribeComplianceByConfigRuleOutput = struct {
    /// Indicates whether each of the specified Config rules is
    /// compliant.
    compliance_by_config_rules: ?[]const ComplianceByConfigRule = null,

    /// The string that you use in a subsequent request to get the next
    /// page of results in a paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .compliance_by_config_rules = "ComplianceByConfigRules",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeComplianceByConfigRuleInput, options: CallOptions) !DescribeComplianceByConfigRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeComplianceByConfigRuleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.DescribeComplianceByConfigRule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeComplianceByConfigRuleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeComplianceByConfigRuleOutput, body, allocator);
}
