const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const UpdateTieringInput = @import("update_tiering_input.zig").UpdateTieringInput;
const PricingRuleType = @import("pricing_rule_type.zig").PricingRuleType;
const PricingRuleScope = @import("pricing_rule_scope.zig").PricingRuleScope;

pub const UpdatePricingRuleInput = struct {
    /// The Amazon Resource Name (ARN) of the pricing rule to update.
    arn: []const u8,

    /// The new description for the pricing rule.
    description: ?[]const u8 = null,

    /// The new modifier to show pricing plan rates as a percentage. Your entry will
    /// be rounded to the nearest 2 decimal places.
    modifier_percentage: ?f64 = null,

    /// The new name of the pricing rule. The name must be unique to each pricing
    /// rule.
    name: ?[]const u8 = null,

    /// The set of tiering configurations for the pricing rule.
    tiering: ?UpdateTieringInput = null,

    /// The new pricing rule type.
    @"type": ?PricingRuleType = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .modifier_percentage = "ModifierPercentage",
        .name = "Name",
        .tiering = "Tiering",
        .@"type" = "Type",
    };
};

pub const UpdatePricingRuleOutput = struct {
    /// The Amazon Resource Name (ARN) of the successfully updated pricing rule.
    arn: ?[]const u8 = null,

    /// The pricing plans count that this pricing rule is associated with.
    associated_pricing_plan_count: ?i64 = null,

    /// The seller of services provided by Amazon Web Services, their affiliates, or
    /// third-party providers selling services via Amazon Web Services Marketplace.
    billing_entity: ?[]const u8 = null,

    /// The new description for the pricing rule.
    description: ?[]const u8 = null,

    /// The most recent time the pricing rule was modified.
    last_modified_time: ?i64 = null,

    /// The new modifier to show pricing plan rates as a percentage.
    modifier_percentage: ?f64 = null,

    /// The new name of the pricing rule. The name must be unique to each pricing
    /// rule.
    name: ?[]const u8 = null,

    /// Operation refers to the specific Amazon Web Services covered by this line
    /// item. This describes the specific usage of the line item.
    ///
    /// If the `Scope` attribute is set to `SKU`, this attribute indicates which
    /// operation the `PricingRule` is modifying. For example, a value of
    /// `RunInstances:0202` indicates the operation of running an Amazon EC2
    /// instance.
    operation: ?[]const u8 = null,

    /// The scope of pricing rule that indicates if it's globally applicable, or
    /// it's service-specific.
    scope: ?PricingRuleScope = null,

    /// If the `Scope` attribute is set to `SERVICE`, the attribute indicates which
    /// service the `PricingRule` is applicable for.
    service: ?[]const u8 = null,

    /// The set of tiering configurations for the pricing rule.
    tiering: ?UpdateTieringInput = null,

    /// The new pricing rule type.
    @"type": ?PricingRuleType = null,

    /// Usage type is the unit that each service uses to measure the usage of a
    /// specific type of resource.
    ///
    /// If the `Scope` attribute is set to `SKU`, this attribute indicates which
    /// usage type the `PricingRule` is modifying. For example,
    /// `USW2-BoxUsage:m2.2xlarge` describes an `M2 High Memory Double Extra Large`
    /// instance in the US West (Oregon) Region.
    usage_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .associated_pricing_plan_count = "AssociatedPricingPlanCount",
        .billing_entity = "BillingEntity",
        .description = "Description",
        .last_modified_time = "LastModifiedTime",
        .modifier_percentage = "ModifierPercentage",
        .name = "Name",
        .operation = "Operation",
        .scope = "Scope",
        .service = "Service",
        .tiering = "Tiering",
        .@"type" = "Type",
        .usage_type = "UsageType",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePricingRuleInput, options: Options) !UpdatePricingRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "billingconductor");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdatePricingRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billingconductor", "billingconductor", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/update-pricing-rule";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, alloc, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.modifier_percentage) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ModifierPercentage\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tiering) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Tiering\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.@"type") |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Type\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdatePricingRuleOutput {
    var result: UpdatePricingRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdatePricingRuleOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
