const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PrincipalType = @import("principal_type.zig").PrincipalType;

pub const AssociatePrincipalWithPortfolioInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The portfolio identifier.
    portfolio_id: []const u8,

    /// The ARN of the principal (user, role, or group). If the `PrincipalType` is
    /// `IAM`, the supported value is a
    /// fully defined
    /// [IAM Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns).
    /// If the `PrincipalType` is `IAM_PATTERN`,
    /// the supported value is an `IAM` ARN *without an AccountID* in the following
    /// format:
    ///
    /// *arn:partition:iam:::resource-type/resource-id*
    ///
    /// The ARN resource-id can be either:
    ///
    /// * A fully formed resource-id. For example,
    ///   *arn:aws:iam:::role/resource-name* or
    /// *arn:aws:iam:::role/resource-path/resource-name*
    ///
    /// * A wildcard ARN. The wildcard ARN accepts `IAM_PATTERN` values with a
    /// "*" or "?" in the resource-id segment of the ARN. For example
    /// *arn:partition:service:::resource-type/resource-path/resource-name*.
    /// The new symbols are exclusive to the **resource-path** and **resource-name**
    /// and cannot replace the **resource-type** or other
    /// ARN values.
    ///
    /// The ARN path and principal name allow unlimited wildcard characters.
    ///
    /// Examples of an **acceptable** wildcard ARN:
    ///
    /// * arn:aws:iam:::role/ResourceName_*
    ///
    /// * arn:aws:iam:::role/*/ResourceName_?
    ///
    /// Examples of an **unacceptable** wildcard ARN:
    ///
    /// * arn:aws:iam:::*/ResourceName
    ///
    /// You can associate multiple `IAM_PATTERN`s even if the account has no
    /// principal
    /// with that name.
    ///
    /// The "?" wildcard character matches zero or one of any character. This is
    /// similar to ".?" in regular
    /// regex context. The "*" wildcard character matches any number of any
    /// characters.
    /// This is similar to ".*" in regular regex context.
    ///
    /// In the IAM Principal ARN format
    /// (*arn:partition:iam:::resource-type/resource-path/resource-name*),
    /// valid resource-type values include **user/**, **group/**,
    /// or **role/**. The "?" and "*" characters
    /// are allowed only after the resource-type in the resource-id segment.
    /// You can use special characters anywhere within the resource-id.
    ///
    /// The "*" character also matches the "/" character, allowing paths to be
    /// formed *within* the
    /// resource-id. For example, *arn:aws:iam:::role/*****/ResourceName_?*
    /// matches both *arn:aws:iam:::role/pathA/pathB/ResourceName_1*
    /// and
    /// *arn:aws:iam:::role/pathA/ResourceName_1*.
    principal_arn: []const u8,

    /// The principal type. The supported value is `IAM` if you use a fully defined
    /// Amazon Resource Name
    /// (ARN), or `IAM_PATTERN` if you use an ARN with no `accountID`,
    /// with or without wildcard characters.
    principal_type: PrincipalType,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .portfolio_id = "PortfolioId",
        .principal_arn = "PrincipalARN",
        .principal_type = "PrincipalType",
    };
};

pub const AssociatePrincipalWithPortfolioOutput = struct {
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociatePrincipalWithPortfolioInput, options: Options) !AssociatePrincipalWithPortfolioOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: AssociatePrincipalWithPortfolioInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AWS242ServiceCatalogService.AssociatePrincipalWithPortfolio");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !AssociatePrincipalWithPortfolioOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    return .{};
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
