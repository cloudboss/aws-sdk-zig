const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const LakehouseIdcRegistration = @import("lakehouse_idc_registration.zig").LakehouseIdcRegistration;
const LakehouseRegistration = @import("lakehouse_registration.zig").LakehouseRegistration;

pub const UpdateLakehouseConfigurationInput = struct {
    /// The name of the Glue Data Catalog that will be associated with the namespace
    /// enabled with Amazon Redshift federated permissions.
    ///
    /// Pattern: `^[a-z0-9_-]*[a-z]+[a-z0-9_-]*$`
    catalog_name: ?[]const u8 = null,

    /// A boolean value that, if `true`, validates the request without actually
    /// updating the lakehouse configuration. Use this to check for errors before
    /// making changes.
    dry_run: ?bool = null,

    /// The Amazon Resource Name (ARN) of the IAM Identity Center application used
    /// for enabling Amazon Web Services IAM Identity Center trusted identity
    /// propagation on a namespace enabled with Amazon Redshift federated
    /// permissions.
    lakehouse_idc_application_arn: ?[]const u8 = null,

    /// Modifies the Amazon Web Services IAM Identity Center trusted identity
    /// propagation on a namespace enabled with Amazon Redshift federated
    /// permissions. Valid values are `Associate` or `Disassociate`.
    lakehouse_idc_registration: ?LakehouseIdcRegistration = null,

    /// Specifies whether to register or deregister the namespace with Amazon
    /// Redshift federated permissions. Valid values are `Register` or `Deregister`.
    lakehouse_registration: ?LakehouseRegistration = null,

    /// The name of the namespace whose lakehouse configuration you want to modify.
    namespace_name: []const u8,

    pub const json_field_names = .{
        .catalog_name = "catalogName",
        .dry_run = "dryRun",
        .lakehouse_idc_application_arn = "lakehouseIdcApplicationArn",
        .lakehouse_idc_registration = "lakehouseIdcRegistration",
        .lakehouse_registration = "lakehouseRegistration",
        .namespace_name = "namespaceName",
    };
};

pub const UpdateLakehouseConfigurationOutput = struct {
    /// The Amazon Resource Name (ARN) of the Glue Data Catalog associated with the
    /// lakehouse configuration.
    catalog_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM Identity Center application used
    /// for enabling Amazon Web Services IAM Identity Center trusted identity
    /// propagation.
    lakehouse_idc_application_arn: ?[]const u8 = null,

    /// The current status of the lakehouse registration. Indicates whether the
    /// namespace is successfully registered with Amazon Redshift federated
    /// permissions.
    lakehouse_registration_status: ?[]const u8 = null,

    /// The name of the namespace.
    namespace_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_arn = "catalogArn",
        .lakehouse_idc_application_arn = "lakehouseIdcApplicationArn",
        .lakehouse_registration_status = "lakehouseRegistrationStatus",
        .namespace_name = "namespaceName",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLakehouseConfigurationInput, options: Options) !UpdateLakehouseConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "redshiftserverless");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLakehouseConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshiftserverless", "Redshift Serverless", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.UpdateLakehouseConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLakehouseConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateLakehouseConfigurationOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
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
    if (std.mem.eql(u8, error_code, "DryRunException")) {
        return .{ .arena = arena, .kind = .{ .dry_run_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientCapacityException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_capacity_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidPaginationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_pagination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "Ipv6CidrBlockNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .ipv_6_cidr_block_not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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
