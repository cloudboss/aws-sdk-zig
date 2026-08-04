const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const UsageRecord = @import("usage_record.zig").UsageRecord;
const UsageRecordResult = @import("usage_record_result.zig").UsageRecordResult;

pub const BatchMeterUsageInput = struct {
    /// Product code is used to uniquely identify a product in Amazon Web Services
    /// Marketplace. The product code should
    /// be the same as the one used during the publishing of a new product.
    product_code: ?[]const u8 = null,

    /// The set of `UsageRecords` to submit. `BatchMeterUsage` accepts
    /// up to 25 `UsageRecords` at a time.
    usage_records: []const UsageRecord,

    pub const json_field_names = .{
        .product_code = "ProductCode",
        .usage_records = "UsageRecords",
    };
};

pub const BatchMeterUsageOutput = struct {
    /// Contains all `UsageRecords` processed by `BatchMeterUsage`.
    /// These records were either honored by Amazon Web Services Marketplace
    /// Metering Service or were invalid. Invalid
    /// records should be fixed before being resubmitted.
    results: ?[]const UsageRecordResult = null,

    /// Contains all `UsageRecords` that were not processed by
    /// `BatchMeterUsage`. This is a list of `UsageRecords`. You can
    /// retry the failed request by making another `BatchMeterUsage` call with this
    /// list as input in the `BatchMeterUsageRequest`.
    unprocessed_records: ?[]const UsageRecord = null,

    pub const json_field_names = .{
        .results = "Results",
        .unprocessed_records = "UnprocessedRecords",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchMeterUsageInput, options: CallOptions) !BatchMeterUsageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aws-marketplace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchMeterUsageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("metering.marketplace", "Marketplace Metering", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSMPMeteringService.BatchMeterUsage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchMeterUsageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchMeterUsageOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "CustomerNotEntitledException")) {
        const parsed_error: ?errors.CustomerNotEntitledException = aws.json.parseJsonObject(errors.CustomerNotEntitledException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .customer_not_entitled_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DisabledApiException")) {
        const parsed_error: ?errors.DisabledApiException = aws.json.parseJsonObject(errors.DisabledApiException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .disabled_api_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateRequestException")) {
        const parsed_error: ?errors.DuplicateRequestException = aws.json.parseJsonObject(errors.DuplicateRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ExpiredTokenException")) {
        const parsed_error: ?errors.ExpiredTokenException = aws.json.parseJsonObject(errors.ExpiredTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .expired_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IdempotencyConflictException")) {
        const parsed_error: ?errors.IdempotencyConflictException = aws.json.parseJsonObject(errors.IdempotencyConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .idempotency_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServiceErrorException")) {
        const parsed_error: ?errors.InternalServiceErrorException = aws.json.parseJsonObject(errors.InternalServiceErrorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_service_error_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidCustomerIdentifierException")) {
        const parsed_error: ?errors.InvalidCustomerIdentifierException = aws.json.parseJsonObject(errors.InvalidCustomerIdentifierException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_customer_identifier_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidEndpointRegionException")) {
        const parsed_error: ?errors.InvalidEndpointRegionException = aws.json.parseJsonObject(errors.InvalidEndpointRegionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_endpoint_region_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidLicenseException")) {
        const parsed_error: ?errors.InvalidLicenseException = aws.json.parseJsonObject(errors.InvalidLicenseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_license_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidProductCodeException")) {
        const parsed_error: ?errors.InvalidProductCodeException = aws.json.parseJsonObject(errors.InvalidProductCodeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_product_code_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPublicKeyVersionException")) {
        const parsed_error: ?errors.InvalidPublicKeyVersionException = aws.json.parseJsonObject(errors.InvalidPublicKeyVersionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_public_key_version_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRegionException")) {
        const parsed_error: ?errors.InvalidRegionException = aws.json.parseJsonObject(errors.InvalidRegionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_region_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTagException")) {
        const parsed_error: ?errors.InvalidTagException = aws.json.parseJsonObject(errors.InvalidTagException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_tag_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTokenException")) {
        const parsed_error: ?errors.InvalidTokenException = aws.json.parseJsonObject(errors.InvalidTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidUsageAllocationsException")) {
        const parsed_error: ?errors.InvalidUsageAllocationsException = aws.json.parseJsonObject(errors.InvalidUsageAllocationsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_usage_allocations_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidUsageDimensionException")) {
        const parsed_error: ?errors.InvalidUsageDimensionException = aws.json.parseJsonObject(errors.InvalidUsageDimensionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_usage_dimension_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PlatformNotSupportedException")) {
        const parsed_error: ?errors.PlatformNotSupportedException = aws.json.parseJsonObject(errors.PlatformNotSupportedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .platform_not_supported_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TimestampOutOfBoundsException")) {
        const parsed_error: ?errors.TimestampOutOfBoundsException = aws.json.parseJsonObject(errors.TimestampOutOfBoundsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .timestamp_out_of_bounds_exception = typed_error } };
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
