const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        customer_not_entitled_exception: CustomerNotEntitledException,
        disabled_api_exception: DisabledApiException,
        duplicate_request_exception: DuplicateRequestException,
        expired_token_exception: ExpiredTokenException,
        idempotency_conflict_exception: IdempotencyConflictException,
        internal_service_error_exception: InternalServiceErrorException,
        invalid_customer_identifier_exception: InvalidCustomerIdentifierException,
        invalid_endpoint_region_exception: InvalidEndpointRegionException,
        invalid_license_exception: InvalidLicenseException,
        invalid_product_code_exception: InvalidProductCodeException,
        invalid_public_key_version_exception: InvalidPublicKeyVersionException,
        invalid_region_exception: InvalidRegionException,
        invalid_tag_exception: InvalidTagException,
        invalid_token_exception: InvalidTokenException,
        invalid_usage_allocations_exception: InvalidUsageAllocationsException,
        invalid_usage_dimension_exception: InvalidUsageDimensionException,
        platform_not_supported_exception: PlatformNotSupportedException,
        throttling_exception: ThrottlingException,
        timestamp_out_of_bounds_exception: TimestampOutOfBoundsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .customer_not_entitled_exception => "CustomerNotEntitledException",
                .disabled_api_exception => "DisabledApiException",
                .duplicate_request_exception => "DuplicateRequestException",
                .expired_token_exception => "ExpiredTokenException",
                .idempotency_conflict_exception => "IdempotencyConflictException",
                .internal_service_error_exception => "InternalServiceErrorException",
                .invalid_customer_identifier_exception => "InvalidCustomerIdentifierException",
                .invalid_endpoint_region_exception => "InvalidEndpointRegionException",
                .invalid_license_exception => "InvalidLicenseException",
                .invalid_product_code_exception => "InvalidProductCodeException",
                .invalid_public_key_version_exception => "InvalidPublicKeyVersionException",
                .invalid_region_exception => "InvalidRegionException",
                .invalid_tag_exception => "InvalidTagException",
                .invalid_token_exception => "InvalidTokenException",
                .invalid_usage_allocations_exception => "InvalidUsageAllocationsException",
                .invalid_usage_dimension_exception => "InvalidUsageDimensionException",
                .platform_not_supported_exception => "PlatformNotSupportedException",
                .throttling_exception => "ThrottlingException",
                .timestamp_out_of_bounds_exception => "TimestampOutOfBoundsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .customer_not_entitled_exception => |e| e.message,
                .disabled_api_exception => |e| e.message,
                .duplicate_request_exception => |e| e.message,
                .expired_token_exception => |e| e.message,
                .idempotency_conflict_exception => |e| e.message,
                .internal_service_error_exception => |e| e.message,
                .invalid_customer_identifier_exception => |e| e.message,
                .invalid_endpoint_region_exception => |e| e.message,
                .invalid_license_exception => |e| e.message,
                .invalid_product_code_exception => |e| e.message,
                .invalid_public_key_version_exception => |e| e.message,
                .invalid_region_exception => |e| e.message,
                .invalid_tag_exception => |e| e.message,
                .invalid_token_exception => |e| e.message,
                .invalid_usage_allocations_exception => |e| e.message,
                .invalid_usage_dimension_exception => |e| e.message,
                .platform_not_supported_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .timestamp_out_of_bounds_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .customer_not_entitled_exception => 400,
                .disabled_api_exception => 400,
                .duplicate_request_exception => 400,
                .expired_token_exception => 400,
                .idempotency_conflict_exception => 409,
                .internal_service_error_exception => 500,
                .invalid_customer_identifier_exception => 400,
                .invalid_endpoint_region_exception => 400,
                .invalid_license_exception => 400,
                .invalid_product_code_exception => 400,
                .invalid_public_key_version_exception => 400,
                .invalid_region_exception => 400,
                .invalid_tag_exception => 400,
                .invalid_token_exception => 400,
                .invalid_usage_allocations_exception => 400,
                .invalid_usage_dimension_exception => 400,
                .platform_not_supported_exception => 400,
                .throttling_exception => 400,
                .timestamp_out_of_bounds_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .customer_not_entitled_exception => |e| e.request_id,
                .disabled_api_exception => |e| e.request_id,
                .duplicate_request_exception => |e| e.request_id,
                .expired_token_exception => |e| e.request_id,
                .idempotency_conflict_exception => |e| e.request_id,
                .internal_service_error_exception => |e| e.request_id,
                .invalid_customer_identifier_exception => |e| e.request_id,
                .invalid_endpoint_region_exception => |e| e.request_id,
                .invalid_license_exception => |e| e.request_id,
                .invalid_product_code_exception => |e| e.request_id,
                .invalid_public_key_version_exception => |e| e.request_id,
                .invalid_region_exception => |e| e.request_id,
                .invalid_tag_exception => |e| e.request_id,
                .invalid_token_exception => |e| e.request_id,
                .invalid_usage_allocations_exception => |e| e.request_id,
                .invalid_usage_dimension_exception => |e| e.request_id,
                .platform_not_supported_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .timestamp_out_of_bounds_exception => |e| e.request_id,
                .unknown => |e| e.request_id,
            };
        }
    };

    pub fn deinit(self: *ServiceError) void {
        if (self.arena) |*a| a.deinit();
    }

    pub fn code(self: ServiceError) []const u8 {
        return self.kind.code();
    }

    pub fn message(self: ServiceError) []const u8 {
        return self.kind.message();
    }

    pub fn httpStatus(self: ServiceError) u16 {
        return self.kind.httpStatus();
    }

    pub fn requestId(self: ServiceError) []const u8 {
        return self.kind.requestId();
    }
};

/// Exception thrown when the customer does not have a valid subscription for
/// the
/// product.
pub const CustomerNotEntitledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The API is disabled in the Region.
pub const DisabledApiException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A metering record has already been emitted by the same EC2 instance, ECS
/// task, or EKS
/// pod for the given {`usageDimension`, `timestamp`} with a different
/// `usageQuantity`.
pub const DuplicateRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The submitted registration token has expired. This can happen if the buyer's
/// browser
/// takes too long to redirect to your page, the buyer has resubmitted the
/// registration
/// token, or your application has held on to the registration token for too
/// long. Your SaaS
/// registration website should redeem this token as soon as it is submitted by
/// the buyer's
/// browser.
pub const ExpiredTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The `ClientToken` is being used for multiple requests.
pub const IdempotencyConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An internal error has occurred. Retry your request. If the problem persists,
/// post a
/// message with details on the Amazon Web Services forums.
pub const InternalServiceErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have metered usage for a `CustomerIdentifier` that does not
/// exist.
pub const InvalidCustomerIdentifierException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The endpoint being called is in a Amazon Web Services Region different from
/// your EC2 instance, ECS
/// task, or EKS pod. The Region of the Metering Service endpoint and the Amazon
/// Web Services Region of
/// the resource must match.
pub const InvalidEndpointRegionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Ensure the `LicenseArn` is valid, matches the customer, and usage is within
/// the license activation period.
pub const InvalidLicenseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The product code passed does not match the product code used for publishing
/// the
/// product.
pub const InvalidProductCodeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Public Key version is invalid.
pub const InvalidPublicKeyVersionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// `RegisterUsage` must be called in the same Amazon Web Services Region the
/// ECS task was
/// launched in. This prevents a container from hardcoding a Region (e.g.
/// withRegion(“us-east-1”) when calling `RegisterUsage`.
pub const InvalidRegionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The tag is invalid, or the number of tags is greater than 5.
pub const InvalidTagException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Registration token is invalid.
pub const InvalidTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Sum of allocated usage quantities is not equal to the usage quantity.
pub const InvalidUsageAllocationsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The usage dimension does not match one of the `UsageDimensions` associated
/// with products.
pub const InvalidUsageDimensionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Amazon Web Services Marketplace does not support metering usage from the
/// underlying platform. Currently, Amazon ECS, Amazon EKS, and Fargate are
/// supported.
pub const PlatformNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The calls to the API are throttled.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The `timestamp` value passed in the `UsageRecord` is out of
/// allowed range.
///
/// For `BatchMeterUsage`, if any of the records are outside of the allowed
/// range, the entire batch is not processed. You must remove invalid records
/// and try
/// again.
pub const TimestampOutOfBoundsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};

/// Parse a service diagnostic. The caller must call deinit on the result.
pub fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) std.mem.Allocator.Error!ServiceError {
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
        const parsed_error: ?CustomerNotEntitledException = aws.json.parseJsonObject(CustomerNotEntitledException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?DisabledApiException = aws.json.parseJsonObject(DisabledApiException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?DuplicateRequestException = aws.json.parseJsonObject(DuplicateRequestException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?ExpiredTokenException = aws.json.parseJsonObject(ExpiredTokenException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?IdempotencyConflictException = aws.json.parseJsonObject(IdempotencyConflictException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InternalServiceErrorException = aws.json.parseJsonObject(InternalServiceErrorException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InvalidCustomerIdentifierException = aws.json.parseJsonObject(InvalidCustomerIdentifierException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InvalidEndpointRegionException = aws.json.parseJsonObject(InvalidEndpointRegionException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InvalidLicenseException = aws.json.parseJsonObject(InvalidLicenseException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InvalidProductCodeException = aws.json.parseJsonObject(InvalidProductCodeException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InvalidPublicKeyVersionException = aws.json.parseJsonObject(InvalidPublicKeyVersionException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InvalidRegionException = aws.json.parseJsonObject(InvalidRegionException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InvalidTagException = aws.json.parseJsonObject(InvalidTagException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InvalidTokenException = aws.json.parseJsonObject(InvalidTokenException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InvalidUsageAllocationsException = aws.json.parseJsonObject(InvalidUsageAllocationsException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?InvalidUsageDimensionException = aws.json.parseJsonObject(InvalidUsageDimensionException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?PlatformNotSupportedException = aws.json.parseJsonObject(PlatformNotSupportedException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?ThrottlingException = aws.json.parseJsonObject(ThrottlingException, body, arena_alloc) catch |err| switch (err) {
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
        const parsed_error: ?TimestampOutOfBoundsException = aws.json.parseJsonObject(TimestampOutOfBoundsException, body, arena_alloc) catch |err| switch (err) {
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
