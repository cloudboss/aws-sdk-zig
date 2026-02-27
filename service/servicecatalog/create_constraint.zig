const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ConstraintDetail = @import("constraint_detail.zig").ConstraintDetail;
const Status = @import("status.zig").Status;

pub const CreateConstraintInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The description of the constraint.
    description: ?[]const u8 = null,

    /// A unique identifier that you provide to ensure idempotency. If multiple
    /// requests differ only by the idempotency token,
    /// the same response is returned for each repeated request.
    idempotency_token: []const u8,

    /// The constraint parameters, in JSON format. The syntax depends on the
    /// constraint type as follows:
    ///
    /// **LAUNCH**
    ///
    /// You are required to specify either the `RoleArn` or the `LocalRoleName` but
    /// can't use both.
    ///
    /// Specify the `RoleArn` property as follows:
    ///
    /// `{"RoleArn" : "arn:aws:iam::123456789012:role/LaunchRole"}`
    ///
    /// Specify the `LocalRoleName` property as follows:
    ///
    /// `{"LocalRoleName": "SCBasicLaunchRole"}`
    ///
    /// If you specify the `LocalRoleName` property, when an account uses the launch
    /// constraint, the IAM role with that name in the account will be used. This
    /// allows launch-role constraints to be
    /// account-agnostic so the administrator can create fewer resources per shared
    /// account.
    ///
    /// The given role name must exist in the account used to create the launch
    /// constraint and the account of the user who launches a product with this
    /// launch constraint.
    ///
    /// You cannot have both a `LAUNCH` and a `STACKSET` constraint.
    ///
    /// You also cannot have more than one `LAUNCH` constraint on a product and
    /// portfolio.
    ///
    /// **NOTIFICATION**
    ///
    /// Specify the `NotificationArns` property as follows:
    ///
    /// `{"NotificationArns" : ["arn:aws:sns:us-east-1:123456789012:Topic"]}`
    ///
    /// **RESOURCE_UPDATE**
    ///
    /// Specify the `TagUpdatesOnProvisionedProduct` property as follows:
    ///
    /// `{"Version":"2.0","Properties":{"TagUpdateOnProvisionedProduct":"String"}}`
    ///
    /// The `TagUpdatesOnProvisionedProduct` property accepts a string value of
    /// `ALLOWED` or `NOT_ALLOWED`.
    ///
    /// **STACKSET**
    ///
    /// Specify the `Parameters` property as follows:
    ///
    /// `{"Version": "String", "Properties": {"AccountList": [ "String" ],
    /// "RegionList": [ "String" ], "AdminRole": "String", "ExecutionRole":
    /// "String"}}`
    ///
    /// You cannot have both a `LAUNCH` and a `STACKSET` constraint.
    ///
    /// You also cannot have more than one `STACKSET` constraint on a product and
    /// portfolio.
    ///
    /// Products with a `STACKSET` constraint will launch an CloudFormation stack
    /// set.
    ///
    /// **TEMPLATE**
    ///
    /// Specify the `Rules` property. For more information, see
    /// [Template Constraint
    /// Rules](http://docs.aws.amazon.com/servicecatalog/latest/adminguide/reference-template_constraint_rules.html).
    parameters: []const u8,

    /// The portfolio identifier.
    portfolio_id: []const u8,

    /// The product identifier.
    product_id: []const u8,

    /// The type of constraint.
    ///
    /// * `LAUNCH`
    ///
    /// * `NOTIFICATION`
    ///
    /// * `RESOURCE_UPDATE`
    ///
    /// * `STACKSET`
    ///
    /// * `TEMPLATE`
    type: []const u8,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .description = "Description",
        .idempotency_token = "IdempotencyToken",
        .parameters = "Parameters",
        .portfolio_id = "PortfolioId",
        .product_id = "ProductId",
        .type = "Type",
    };
};

pub const CreateConstraintOutput = struct {
    /// Information about the constraint.
    constraint_detail: ?ConstraintDetail = null,

    /// The constraint parameters.
    constraint_parameters: ?[]const u8 = null,

    /// The status of the current request.
    status: ?Status = null,

    pub const json_field_names = .{
        .constraint_detail = "ConstraintDetail",
        .constraint_parameters = "ConstraintParameters",
        .status = "Status",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConstraintInput, options: Options) !CreateConstraintOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "servicecatalog");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateConstraintInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicecatalog", "Service Catalog", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AWS242ServiceCatalogService.CreateConstraint");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateConstraintOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateConstraintOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "DuplicateResourceException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_resource_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParametersException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameters_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
    if (std.mem.eql(u8, error_code, "TagOptionNotMigratedException")) {
        return .{ .arena = arena, .kind = .{ .tag_option_not_migrated_exception = .{
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
