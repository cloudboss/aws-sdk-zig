const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AutomatedDiscoveryInformation = @import("automated_discovery_information.zig").AutomatedDiscoveryInformation;
const ConsumedLicenseSummary = @import("consumed_license_summary.zig").ConsumedLicenseSummary;
const LicenseCountingType = @import("license_counting_type.zig").LicenseCountingType;
const ManagedResourceSummary = @import("managed_resource_summary.zig").ManagedResourceSummary;
const ProductInformation = @import("product_information.zig").ProductInformation;
const Tag = @import("tag.zig").Tag;

pub const GetLicenseConfigurationInput = struct {
    /// Amazon Resource Name (ARN) of the license configuration.
    license_configuration_arn: []const u8,

    pub const json_field_names = .{
        .license_configuration_arn = "LicenseConfigurationArn",
    };
};

pub const GetLicenseConfigurationOutput = struct {
    /// Automated discovery information.
    automated_discovery_information: ?AutomatedDiscoveryInformation = null,

    /// Number of licenses assigned to resources.
    consumed_licenses: ?i64 = null,

    /// Summaries of the licenses consumed by resources.
    consumed_license_summary_list: ?[]const ConsumedLicenseSummary = null,

    /// Description of the license configuration.
    description: ?[]const u8 = null,

    /// When true, disassociates a resource when software is uninstalled.
    disassociate_when_not_found: ?bool = null,

    /// Amazon Resource Name (ARN) of the license configuration.
    license_configuration_arn: ?[]const u8 = null,

    /// Unique ID for the license configuration.
    license_configuration_id: ?[]const u8 = null,

    /// Number of available licenses.
    license_count: ?i64 = null,

    /// Sets the number of available licenses as a hard limit.
    license_count_hard_limit: ?bool = null,

    /// Dimension for which the licenses are counted.
    license_counting_type: ?LicenseCountingType = null,

    /// License Expiry.
    license_expiry: ?i64 = null,

    /// License rules.
    license_rules: ?[]const []const u8 = null,

    /// Summaries of the managed resources.
    managed_resource_summary_list: ?[]const ManagedResourceSummary = null,

    /// Name of the license configuration.
    name: ?[]const u8 = null,

    /// Account ID of the owner of the license configuration.
    owner_account_id: ?[]const u8 = null,

    /// Product information.
    product_information_list: ?[]const ProductInformation = null,

    /// License configuration status.
    status: ?[]const u8 = null,

    /// Tags for the license configuration.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .automated_discovery_information = "AutomatedDiscoveryInformation",
        .consumed_licenses = "ConsumedLicenses",
        .consumed_license_summary_list = "ConsumedLicenseSummaryList",
        .description = "Description",
        .disassociate_when_not_found = "DisassociateWhenNotFound",
        .license_configuration_arn = "LicenseConfigurationArn",
        .license_configuration_id = "LicenseConfigurationId",
        .license_count = "LicenseCount",
        .license_count_hard_limit = "LicenseCountHardLimit",
        .license_counting_type = "LicenseCountingType",
        .license_expiry = "LicenseExpiry",
        .license_rules = "LicenseRules",
        .managed_resource_summary_list = "ManagedResourceSummaryList",
        .name = "Name",
        .owner_account_id = "OwnerAccountId",
        .product_information_list = "ProductInformationList",
        .status = "Status",
        .tags = "Tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLicenseConfigurationInput, options: Options) !GetLicenseConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLicenseConfigurationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.GetLicenseConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLicenseConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetLicenseConfigurationOutput, body, allocator);
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
