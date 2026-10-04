const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CostCategoryRule = @import("cost_category_rule.zig").CostCategoryRule;
const CostCategoryRuleVersion = @import("cost_category_rule_version.zig").CostCategoryRuleVersion;
const CostCategorySplitChargeRule = @import("cost_category_split_charge_rule.zig").CostCategorySplitChargeRule;

pub const UpdateCostCategoryDefinitionInput = struct {
    /// The unique identifier for your cost category.
    cost_category_arn: []const u8,

    default_value: ?[]const u8 = null,

    /// The cost category's effective start date. It can only be a billing start
    /// date (first day of the month). If the date isn't provided, it's the first
    /// day of the current month. Dates can't be before the previous twelve months,
    /// or in the future.
    effective_start: ?[]const u8 = null,

    /// The `Expression` object used to categorize costs. For more information, see
    /// [CostCategoryRule
    /// ](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_CostCategoryRule.html).
    rules: []const CostCategoryRule,

    rule_version: CostCategoryRuleVersion,

    /// The split charge rules used to allocate your charges between your cost
    /// category values.
    split_charge_rules: ?[]const CostCategorySplitChargeRule = null,

    pub const json_field_names = .{
        .cost_category_arn = "CostCategoryArn",
        .default_value = "DefaultValue",
        .effective_start = "EffectiveStart",
        .rules = "Rules",
        .rule_version = "RuleVersion",
        .split_charge_rules = "SplitChargeRules",
    };
};

pub const UpdateCostCategoryDefinitionOutput = struct {
    /// The unique identifier for your cost category.
    cost_category_arn: ?[]const u8 = null,

    /// The cost category's effective start date. It can only be a billing start
    /// date (first day of the month).
    effective_start: ?[]const u8 = null,

    pub const json_field_names = .{
        .cost_category_arn = "CostCategoryArn",
        .effective_start = "EffectiveStart",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCostCategoryDefinitionInput, options: CallOptions) !UpdateCostCategoryDefinitionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCostCategoryDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ce", "Cost Explorer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.UpdateCostCategoryDefinition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCostCategoryDefinitionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateCostCategoryDefinitionOutput, body, allocator);
}
