const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        analysis_not_found_exception: AnalysisNotFoundException,
        backfill_limit_exceeded_exception: BackfillLimitExceededException,
        bill_expiration_exception: BillExpirationException,
        billing_view_health_status_exception: BillingViewHealthStatusException,
        data_unavailable_exception: DataUnavailableException,
        generation_exists_exception: GenerationExistsException,
        invalid_next_token_exception: InvalidNextTokenException,
        limit_exceeded_exception: LimitExceededException,
        request_changed_exception: RequestChangedException,
        resource_not_found_exception: ResourceNotFoundException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        too_many_tags_exception: TooManyTagsException,
        unknown_monitor_exception: UnknownMonitorException,
        unknown_subscription_exception: UnknownSubscriptionException,
        unresolvable_usage_unit_exception: UnresolvableUsageUnitException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .analysis_not_found_exception => "AnalysisNotFoundException",
                .backfill_limit_exceeded_exception => "BackfillLimitExceededException",
                .bill_expiration_exception => "BillExpirationException",
                .billing_view_health_status_exception => "BillingViewHealthStatusException",
                .data_unavailable_exception => "DataUnavailableException",
                .generation_exists_exception => "GenerationExistsException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .limit_exceeded_exception => "LimitExceededException",
                .request_changed_exception => "RequestChangedException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .too_many_tags_exception => "TooManyTagsException",
                .unknown_monitor_exception => "UnknownMonitorException",
                .unknown_subscription_exception => "UnknownSubscriptionException",
                .unresolvable_usage_unit_exception => "UnresolvableUsageUnitException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .analysis_not_found_exception => |e| e.message,
                .backfill_limit_exceeded_exception => |e| e.message,
                .bill_expiration_exception => |e| e.message,
                .billing_view_health_status_exception => |e| e.message,
                .data_unavailable_exception => |e| e.message,
                .generation_exists_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .request_changed_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unknown_monitor_exception => |e| e.message,
                .unknown_subscription_exception => |e| e.message,
                .unresolvable_usage_unit_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .analysis_not_found_exception => 400,
                .backfill_limit_exceeded_exception => 400,
                .bill_expiration_exception => 400,
                .billing_view_health_status_exception => 400,
                .data_unavailable_exception => 400,
                .generation_exists_exception => 400,
                .invalid_next_token_exception => 400,
                .limit_exceeded_exception => 400,
                .request_changed_exception => 400,
                .resource_not_found_exception => 404,
                .service_quota_exceeded_exception => 402,
                .too_many_tags_exception => 400,
                .unknown_monitor_exception => 404,
                .unknown_subscription_exception => 404,
                .unresolvable_usage_unit_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .analysis_not_found_exception => |e| e.request_id,
                .backfill_limit_exceeded_exception => |e| e.request_id,
                .bill_expiration_exception => |e| e.request_id,
                .billing_view_health_status_exception => |e| e.request_id,
                .data_unavailable_exception => |e| e.request_id,
                .generation_exists_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .request_changed_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
                .unknown_monitor_exception => |e| e.request_id,
                .unknown_subscription_exception => |e| e.request_id,
                .unresolvable_usage_unit_exception => |e| e.request_id,
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

pub const AnalysisNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BackfillLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BillExpirationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BillingViewHealthStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DataUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GenerationExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RequestChangedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownMonitorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownSubscriptionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnresolvableUsageUnitException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
