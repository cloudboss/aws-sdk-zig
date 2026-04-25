const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const ResolveCustomerInput = struct {
    /// When a buyer visits your website during the registration process, the buyer
    /// submits a
    /// registration token through the browser. The registration token is resolved
    /// to obtain a
    /// `CustomerIdentifier` along with the `CustomerAWSAccountId`,
    /// `ProductCode`, and `LicenseArn`.
    registration_token: []const u8,

    pub const json_field_names = .{
        .registration_token = "RegistrationToken",
    };
};

pub const ResolveCustomerOutput = struct {
    /// The `CustomerAWSAccountId` provides the Amazon Web Services account ID
    /// associated with
    /// the `CustomerIdentifier` for the individual customer. Calls to
    /// `BatchMeterUsage` require
    /// `CustomerAWSAccountId` for each `UsageRecord`.
    customer_aws_account_id: ?[]const u8 = null,

    /// The `CustomerIdentifier` is used to identify an individual customer in your
    /// application.
    customer_identifier: ?[]const u8 = null,

    /// The `LicenseArn` is a unique identifier for a specific granted license.
    /// These are typically used for software purchased through Amazon Web Services
    /// Marketplace. Calls to `BatchMeterUsage` require `LicenseArn` for each
    /// `UsageRecord`.
    ///
    /// Once you receive the `CustomerAWSAccountId` and `LicenseArn` in the
    /// response, store that for future purposes/API calls/integrations.
    license_arn: ?[]const u8 = null,

    /// The product code is returned to confirm that the buyer is registering for
    /// your
    /// product. Subsequent `BatchMeterUsage` calls should be made using this
    /// product
    /// code.
    product_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .customer_aws_account_id = "CustomerAWSAccountId",
        .customer_identifier = "CustomerIdentifier",
        .license_arn = "LicenseArn",
        .product_code = "ProductCode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ResolveCustomerInput, options: CallOptions) !ResolveCustomerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "aws-marketplace");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ResolveCustomerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("metering.marketplace", "Marketplace Metering", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPMeteringService.ResolveCustomer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ResolveCustomerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ResolveCustomerOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "CustomerNotEntitledException")) {
        return .{ .arena = arena, .kind = .{ .customer_not_entitled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DisabledApiException")) {
        return .{ .arena = arena, .kind = .{ .disabled_api_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateRequestException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExpiredTokenException")) {
        return .{ .arena = arena, .kind = .{ .expired_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotencyConflictException")) {
        return .{ .arena = arena, .kind = .{ .idempotency_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCustomerIdentifierException")) {
        return .{ .arena = arena, .kind = .{ .invalid_customer_identifier_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEndpointRegionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_endpoint_region_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLicenseException")) {
        return .{ .arena = arena, .kind = .{ .invalid_license_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidProductCodeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_product_code_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPublicKeyVersionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_public_key_version_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRegionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_region_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTagException")) {
        return .{ .arena = arena, .kind = .{ .invalid_tag_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidUsageAllocationsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_usage_allocations_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidUsageDimensionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_usage_dimension_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PlatformNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .platform_not_supported_exception = .{
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
    if (std.mem.eql(u8, error_code, "TimestampOutOfBoundsException")) {
        return .{ .arena = arena, .kind = .{ .timestamp_out_of_bounds_exception = .{
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
