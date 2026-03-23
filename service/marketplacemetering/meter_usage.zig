const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const UsageAllocation = @import("usage_allocation.zig").UsageAllocation;

pub const MeterUsageInput = struct {
    /// Specifies a unique, case-sensitive identifier that you provide to ensure the
    /// idempotency
    /// of the request. This lets you safely retry the request without accidentally
    /// performing the
    /// same operation a second time. Passing the same value to a later call to an
    /// operation
    /// requires that you also pass the same value for all other parameters. We
    /// recommend that you
    /// use a [UUID type of
    /// value](https://wikipedia.org/wiki/Universally_unique_identifier).
    ///
    /// If you don't provide this value, then Amazon Web Services generates a random
    /// one for
    /// you.
    ///
    /// If you retry the operation with the same `ClientToken`, but with different
    /// parameters, the retry fails with an `IdempotencyConflictException` error.
    client_token: ?[]const u8 = null,

    /// Checks whether you have the permissions required for the action, but does
    /// not make the
    /// request. If you have the permissions, the request returns `DryRunOperation`;
    /// otherwise, it returns `UnauthorizedException`. Defaults to `false`
    /// if not specified.
    dry_run: ?bool = null,

    /// Product code is used to uniquely identify a product in Amazon Web Services
    /// Marketplace. The product code
    /// should be the same as the one used during the publishing of a new product.
    product_code: []const u8,

    /// Timestamp, in UTC, for which the usage is being reported. Your application
    /// can meter
    /// usage for up to six hours in the past. Make sure the `timestamp` value is
    /// not
    /// before the start of the software usage.
    timestamp: i64,

    /// The set of `UsageAllocations` to submit.
    ///
    /// The sum of all `UsageAllocation` quantities must equal the
    /// `UsageQuantity` of the `MeterUsage` request, and each
    /// `UsageAllocation` must have a unique set of tags (include no
    /// tags).
    usage_allocations: ?[]const UsageAllocation = null,

    /// It will be one of the fcp dimension name provided during the publishing of
    /// the
    /// product.
    usage_dimension: []const u8,

    /// Consumption value for the hour. Defaults to `0` if not specified.
    usage_quantity: ?i32 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .dry_run = "DryRun",
        .product_code = "ProductCode",
        .timestamp = "Timestamp",
        .usage_allocations = "UsageAllocations",
        .usage_dimension = "UsageDimension",
        .usage_quantity = "UsageQuantity",
    };
};

pub const MeterUsageOutput = struct {
    /// Metering record id.
    metering_record_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .metering_record_id = "MeteringRecordId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: MeterUsageInput, options: CallOptions) !MeterUsageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: MeterUsageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPMeteringService.MeterUsage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !MeterUsageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(MeterUsageOutput, body, allocator);
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
