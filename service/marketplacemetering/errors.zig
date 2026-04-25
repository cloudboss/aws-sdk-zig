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

pub const CustomerNotEntitledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DisabledApiException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExpiredTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IdempotencyConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServiceErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCustomerIdentifierException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidEndpointRegionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidLicenseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidProductCodeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPublicKeyVersionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRegionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTagException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidUsageAllocationsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidUsageDimensionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PlatformNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TimestampOutOfBoundsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
