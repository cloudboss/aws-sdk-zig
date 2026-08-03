const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const ResourceTag = @import("resource_tag.zig").ResourceTag;
const CostCategoryRule = @import("cost_category_rule.zig").CostCategoryRule;
const CostCategoryRuleVersion = @import("cost_category_rule_version.zig").CostCategoryRuleVersion;
const CostCategorySplitChargeRule = @import("cost_category_split_charge_rule.zig").CostCategorySplitChargeRule;

pub const CreateCostCategoryDefinitionInput = struct {
    default_value: ?[]const u8 = null,

    /// The cost category's effective start date. It can only be a billing start
    /// date (first day of the month). If the date isn't provided, it's the first
    /// day of the current month. Dates can't be before the previous twelve months,
    /// or in the future.
    effective_start: ?[]const u8 = null,

    name: []const u8,

    /// An optional list of tags to associate with the specified [
    /// `CostCategory`
    /// ](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_CostCategory.html). You can use resource tags to control access to your
    /// `cost category` using IAM policies.
    ///
    /// Each tag consists of a key and a value, and each key must be unique for the
    /// resource. The
    /// following restrictions apply to resource tags:
    ///
    /// * Although the maximum number of array members is 200, you can assign a
    ///   maximum of 50
    /// user-tags to one resource. The remaining are reserved for Amazon Web
    /// Services use
    ///
    /// * The maximum length of a key is 128 characters
    ///
    /// * The maximum length of a value is 256 characters
    ///
    /// * Keys and values can only contain alphanumeric characters, spaces, and any
    ///   of the
    /// following: `_.:/=+@-`
    ///
    /// * Keys and values are case sensitive
    ///
    /// * Keys and values are trimmed for any leading or trailing whitespaces
    ///
    /// * Don’t use `aws:` as a prefix for your keys. This prefix is reserved for
    /// Amazon Web Services use
    resource_tags: ?[]const ResourceTag = null,

    /// The cost category rules used to categorize costs. For more information, see
    /// [CostCategoryRule](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_CostCategoryRule.html).
    rules: []const CostCategoryRule,

    rule_version: CostCategoryRuleVersion,

    /// The split charge rules used to allocate your charges between your cost
    /// category values.
    split_charge_rules: ?[]const CostCategorySplitChargeRule = null,

    pub const json_field_names = .{
        .default_value = "DefaultValue",
        .effective_start = "EffectiveStart",
        .name = "Name",
        .resource_tags = "ResourceTags",
        .rules = "Rules",
        .rule_version = "RuleVersion",
        .split_charge_rules = "SplitChargeRules",
    };
};

pub const CreateCostCategoryDefinitionOutput = struct {
    /// The unique identifier for your newly created cost category.
    cost_category_arn: ?[]const u8 = null,

    /// The cost category's effective start date. It can only be a billing start
    /// date (first day of the month).
    effective_start: ?[]const u8 = null,

    pub const json_field_names = .{
        .cost_category_arn = "CostCategoryArn",
        .effective_start = "EffectiveStart",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCostCategoryDefinitionInput, options: CallOptions) !CreateCostCategoryDefinitionOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCostCategoryDefinitionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.CreateCostCategoryDefinition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCostCategoryDefinitionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCostCategoryDefinitionOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AnalysisNotFoundException")) {
        const parsed_error: ?errors.AnalysisNotFoundException = aws.json.parseJsonObject(errors.AnalysisNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .analysis_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BackfillLimitExceededException")) {
        const parsed_error: ?errors.BackfillLimitExceededException = aws.json.parseJsonObject(errors.BackfillLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .backfill_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BillExpirationException")) {
        const parsed_error: ?errors.BillExpirationException = aws.json.parseJsonObject(errors.BillExpirationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .bill_expiration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BillingViewHealthStatusException")) {
        const parsed_error: ?errors.BillingViewHealthStatusException = aws.json.parseJsonObject(errors.BillingViewHealthStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .billing_view_health_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DataUnavailableException")) {
        const parsed_error: ?errors.DataUnavailableException = aws.json.parseJsonObject(errors.DataUnavailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .data_unavailable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "GenerationExistsException")) {
        const parsed_error: ?errors.GenerationExistsException = aws.json.parseJsonObject(errors.GenerationExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .generation_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        const parsed_error: ?errors.InvalidNextTokenException = aws.json.parseJsonObject(errors.InvalidNextTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RequestChangedException")) {
        const parsed_error: ?errors.RequestChangedException = aws.json.parseJsonObject(errors.RequestChangedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .request_changed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        const parsed_error: ?errors.ServiceQuotaExceededException = aws.json.parseJsonObject(errors.ServiceQuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        const parsed_error: ?errors.TooManyTagsException = aws.json.parseJsonObject(errors.TooManyTagsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnknownMonitorException")) {
        const parsed_error: ?errors.UnknownMonitorException = aws.json.parseJsonObject(errors.UnknownMonitorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unknown_monitor_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnknownSubscriptionException")) {
        const parsed_error: ?errors.UnknownSubscriptionException = aws.json.parseJsonObject(errors.UnknownSubscriptionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unknown_subscription_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnresolvableUsageUnitException")) {
        const parsed_error: ?errors.UnresolvableUsageUnitException = aws.json.parseJsonObject(errors.UnresolvableUsageUnitException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unresolvable_usage_unit_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
