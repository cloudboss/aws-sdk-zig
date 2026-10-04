const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProtectConfigurationRuleSetNumberOverrideFilterItem = @import("protect_configuration_rule_set_number_override_filter_item.zig").ProtectConfigurationRuleSetNumberOverrideFilterItem;
const ProtectConfigurationRuleSetNumberOverride = @import("protect_configuration_rule_set_number_override.zig").ProtectConfigurationRuleSetNumberOverride;

pub const ListProtectConfigurationRuleSetNumberOverridesInput = struct {
    /// An array of ProtectConfigurationRuleSetNumberOverrideFilterItem objects to
    /// filter the results.
    filters: ?[]const ProtectConfigurationRuleSetNumberOverrideFilterItem = null,

    /// The maximum number of results to return per each request.
    max_results: ?i32 = null,

    /// The token to be used for the next set of paginated results. You don't need
    /// to supply a value for this field in the initial request.
    next_token: ?[]const u8 = null,

    /// The unique identifier for the protect configuration.
    protect_configuration_id: []const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .protect_configuration_id = "ProtectConfigurationId",
    };
};

pub const ListProtectConfigurationRuleSetNumberOverridesOutput = struct {
    /// The token to be used for the next set of paginated results. You don't need
    /// to supply a value for this field in the initial request.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the protect configuration.
    protect_configuration_arn: []const u8,

    /// The unique identifier for the protect configuration.
    protect_configuration_id: []const u8,

    /// An array of RuleSetNumberOverrides objects.
    rule_set_number_overrides: ?[]const ProtectConfigurationRuleSetNumberOverride = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .protect_configuration_arn = "ProtectConfigurationArn",
        .protect_configuration_id = "ProtectConfigurationId",
        .rule_set_number_overrides = "RuleSetNumberOverrides",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListProtectConfigurationRuleSetNumberOverridesInput, options: CallOptions) !ListProtectConfigurationRuleSetNumberOverridesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sms-voice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListProtectConfigurationRuleSetNumberOverridesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sms-voice", "Pinpoint SMS Voice V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.ListProtectConfigurationRuleSetNumberOverrides");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListProtectConfigurationRuleSetNumberOverridesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListProtectConfigurationRuleSetNumberOverridesOutput, body, allocator);
}
