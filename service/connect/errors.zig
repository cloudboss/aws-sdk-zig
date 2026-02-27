const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        conditional_operation_failed_exception: ConditionalOperationFailedException,
        conflict_exception: ConflictException,
        contact_flow_not_published_exception: ContactFlowNotPublishedException,
        contact_not_found_exception: ContactNotFoundException,
        destination_not_allowed_exception: DestinationNotAllowedException,
        duplicate_resource_exception: DuplicateResourceException,
        idempotency_exception: IdempotencyException,
        internal_service_exception: InternalServiceException,
        invalid_active_region_exception: InvalidActiveRegionException,
        invalid_contact_flow_exception: InvalidContactFlowException,
        invalid_contact_flow_module_exception: InvalidContactFlowModuleException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_request_exception: InvalidRequestException,
        invalid_test_case_exception: InvalidTestCaseException,
        limit_exceeded_exception: LimitExceededException,
        maximum_result_returned_exception: MaximumResultReturnedException,
        outbound_contact_not_permitted_exception: OutboundContactNotPermittedException,
        output_type_not_found_exception: OutputTypeNotFoundException,
        property_validation_exception: PropertyValidationException,
        resource_conflict_exception: ResourceConflictException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_found_exception: ResourceNotFoundException,
        resource_not_ready_exception: ResourceNotReadyException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        throttling_exception: ThrottlingException,
        too_many_requests_exception: TooManyRequestsException,
        user_not_found_exception: UserNotFoundException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .conditional_operation_failed_exception => "ConditionalOperationFailedException",
                .conflict_exception => "ConflictException",
                .contact_flow_not_published_exception => "ContactFlowNotPublishedException",
                .contact_not_found_exception => "ContactNotFoundException",
                .destination_not_allowed_exception => "DestinationNotAllowedException",
                .duplicate_resource_exception => "DuplicateResourceException",
                .idempotency_exception => "IdempotencyException",
                .internal_service_exception => "InternalServiceException",
                .invalid_active_region_exception => "InvalidActiveRegionException",
                .invalid_contact_flow_exception => "InvalidContactFlowException",
                .invalid_contact_flow_module_exception => "InvalidContactFlowModuleException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_request_exception => "InvalidRequestException",
                .invalid_test_case_exception => "InvalidTestCaseException",
                .limit_exceeded_exception => "LimitExceededException",
                .maximum_result_returned_exception => "MaximumResultReturnedException",
                .outbound_contact_not_permitted_exception => "OutboundContactNotPermittedException",
                .output_type_not_found_exception => "OutputTypeNotFoundException",
                .property_validation_exception => "PropertyValidationException",
                .resource_conflict_exception => "ResourceConflictException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .resource_not_ready_exception => "ResourceNotReadyException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .throttling_exception => "ThrottlingException",
                .too_many_requests_exception => "TooManyRequestsException",
                .user_not_found_exception => "UserNotFoundException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .conditional_operation_failed_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .contact_flow_not_published_exception => |e| e.message,
                .contact_not_found_exception => |e| e.message,
                .destination_not_allowed_exception => |e| e.message,
                .duplicate_resource_exception => |e| e.message,
                .idempotency_exception => |e| e.message,
                .internal_service_exception => |e| e.message,
                .invalid_active_region_exception => |e| e.message,
                .invalid_contact_flow_exception => |e| e.message,
                .invalid_contact_flow_module_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .invalid_test_case_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .maximum_result_returned_exception => |e| e.message,
                .outbound_contact_not_permitted_exception => |e| e.message,
                .output_type_not_found_exception => |e| e.message,
                .property_validation_exception => |e| e.message,
                .resource_conflict_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .resource_not_ready_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .user_not_found_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .conditional_operation_failed_exception => 409,
                .conflict_exception => 409,
                .contact_flow_not_published_exception => 404,
                .contact_not_found_exception => 410,
                .destination_not_allowed_exception => 403,
                .duplicate_resource_exception => 409,
                .idempotency_exception => 409,
                .internal_service_exception => 500,
                .invalid_active_region_exception => 400,
                .invalid_contact_flow_exception => 400,
                .invalid_contact_flow_module_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_request_exception => 400,
                .invalid_test_case_exception => 400,
                .limit_exceeded_exception => 429,
                .maximum_result_returned_exception => 400,
                .outbound_contact_not_permitted_exception => 403,
                .output_type_not_found_exception => 404,
                .property_validation_exception => 400,
                .resource_conflict_exception => 409,
                .resource_in_use_exception => 409,
                .resource_not_found_exception => 404,
                .resource_not_ready_exception => 409,
                .service_quota_exceeded_exception => 402,
                .throttling_exception => 429,
                .too_many_requests_exception => 429,
                .user_not_found_exception => 404,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .conditional_operation_failed_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .contact_flow_not_published_exception => |e| e.request_id,
                .contact_not_found_exception => |e| e.request_id,
                .destination_not_allowed_exception => |e| e.request_id,
                .duplicate_resource_exception => |e| e.request_id,
                .idempotency_exception => |e| e.request_id,
                .internal_service_exception => |e| e.request_id,
                .invalid_active_region_exception => |e| e.request_id,
                .invalid_contact_flow_exception => |e| e.request_id,
                .invalid_contact_flow_module_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .invalid_test_case_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .maximum_result_returned_exception => |e| e.request_id,
                .outbound_contact_not_permitted_exception => |e| e.request_id,
                .output_type_not_found_exception => |e| e.request_id,
                .property_validation_exception => |e| e.request_id,
                .resource_conflict_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .resource_not_ready_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
                .user_not_found_exception => |e| e.request_id,
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

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConditionalOperationFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ContactFlowNotPublishedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ContactNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DestinationNotAllowedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateResourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IdempotencyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidActiveRegionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidContactFlowException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidContactFlowModuleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTestCaseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaximumResultReturnedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OutboundContactNotPermittedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OutputTypeNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PropertyValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotReadyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UserNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
