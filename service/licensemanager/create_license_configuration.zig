const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const LicenseCountingType = @import("license_counting_type.zig").LicenseCountingType;
const ProductInformation = @import("product_information.zig").ProductInformation;
const Tag = @import("tag.zig").Tag;

pub const CreateLicenseConfigurationInput = struct {
    /// Description of the license configuration.
    description: ?[]const u8 = null,

    /// When true, disassociates a resource when software is uninstalled.
    disassociate_when_not_found: ?bool = null,

    /// Number of licenses managed by the license configuration.
    license_count: ?i64 = null,

    /// Indicates whether hard or soft license enforcement is used. Exceeding a hard
    /// limit
    /// blocks the launch of new instances.
    license_count_hard_limit: ?bool = null,

    /// Dimension used to track the license inventory.
    license_counting_type: LicenseCountingType,

    /// License configuration expiry.
    license_expiry: ?i64 = null,

    /// License rules. The syntax is #name=value (for example,
    /// #allowedTenancy=EC2-DedicatedHost). The available rules
    /// vary by dimension, as follows.
    ///
    /// * `Cores` dimension: `allowedTenancy` |
    /// `licenseAffinityToHost` |
    /// `maximumCores` | `minimumCores`
    ///
    /// * `Instances` dimension: `allowedTenancy` |
    /// `maximumVcpus` | `minimumVcpus`
    ///
    /// * `Sockets` dimension: `allowedTenancy` |
    /// `licenseAffinityToHost` |
    /// `maximumSockets` | `minimumSockets`
    ///
    /// * `vCPUs` dimension: `allowedTenancy` |
    /// `honorVcpuOptimization` |
    /// `maximumVcpus` | `minimumVcpus`
    ///
    /// The unit for `licenseAffinityToHost` is days and the range is 1 to 180. The
    /// possible
    /// values for `allowedTenancy` are `EC2-Default`, `EC2-DedicatedHost`, and
    /// `EC2-DedicatedInstance`. The possible values for `honorVcpuOptimization` are
    /// `True` and `False`.
    license_rules: ?[]const []const u8 = null,

    /// Name of the license configuration.
    name: []const u8,

    /// Product information.
    product_information_list: ?[]const ProductInformation = null,

    /// Tags to add to the license configuration.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "Description",
        .disassociate_when_not_found = "DisassociateWhenNotFound",
        .license_count = "LicenseCount",
        .license_count_hard_limit = "LicenseCountHardLimit",
        .license_counting_type = "LicenseCountingType",
        .license_expiry = "LicenseExpiry",
        .license_rules = "LicenseRules",
        .name = "Name",
        .product_information_list = "ProductInformationList",
        .tags = "Tags",
    };
};

pub const CreateLicenseConfigurationOutput = struct {
    /// Amazon Resource Name (ARN) of the license configuration.
    license_configuration_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .license_configuration_arn = "LicenseConfigurationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLicenseConfigurationInput, options: CallOptions) !CreateLicenseConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "licensemanager");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLicenseConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("licensemanager", "License Manager", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.CreateLicenseConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLicenseConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLicenseConfigurationOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "AuthorizationException")) {
        return .{ .arena = arena, .kind = .{ .authorization_exception = .{
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
    if (std.mem.eql(u8, error_code, "EntitlementNotAllowedException")) {
        return .{ .arena = arena, .kind = .{ .entitlement_not_allowed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FailedDependencyException")) {
        return .{ .arena = arena, .kind = .{ .failed_dependency_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FilterLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .filter_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LicenseUsageException")) {
        return .{ .arena = arena, .kind = .{ .license_usage_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoEntitlementsAllowedException")) {
        return .{ .arena = arena, .kind = .{ .no_entitlements_allowed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RateLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .rate_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RedirectException")) {
        return .{ .arena = arena, .kind = .{ .redirect_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServerInternalException")) {
        return .{ .arena = arena, .kind = .{ .server_internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedDigitalSignatureMethodException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_digital_signature_method_exception = .{
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
