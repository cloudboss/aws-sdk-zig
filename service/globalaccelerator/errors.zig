const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        accelerator_not_disabled_exception: AcceleratorNotDisabledException,
        accelerator_not_found_exception: AcceleratorNotFoundException,
        access_denied_exception: AccessDeniedException,
        associated_endpoint_group_found_exception: AssociatedEndpointGroupFoundException,
        associated_listener_found_exception: AssociatedListenerFoundException,
        attachment_not_found_exception: AttachmentNotFoundException,
        byoip_cidr_not_found_exception: ByoipCidrNotFoundException,
        conflict_exception: ConflictException,
        endpoint_already_exists_exception: EndpointAlreadyExistsException,
        endpoint_group_already_exists_exception: EndpointGroupAlreadyExistsException,
        endpoint_group_not_found_exception: EndpointGroupNotFoundException,
        endpoint_not_found_exception: EndpointNotFoundException,
        incorrect_cidr_state_exception: IncorrectCidrStateException,
        internal_service_error_exception: InternalServiceErrorException,
        invalid_argument_exception: InvalidArgumentException,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_port_range_exception: InvalidPortRangeException,
        limit_exceeded_exception: LimitExceededException,
        listener_not_found_exception: ListenerNotFoundException,
        transaction_in_progress_exception: TransactionInProgressException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .accelerator_not_disabled_exception => "AcceleratorNotDisabledException",
                .accelerator_not_found_exception => "AcceleratorNotFoundException",
                .access_denied_exception => "AccessDeniedException",
                .associated_endpoint_group_found_exception => "AssociatedEndpointGroupFoundException",
                .associated_listener_found_exception => "AssociatedListenerFoundException",
                .attachment_not_found_exception => "AttachmentNotFoundException",
                .byoip_cidr_not_found_exception => "ByoipCidrNotFoundException",
                .conflict_exception => "ConflictException",
                .endpoint_already_exists_exception => "EndpointAlreadyExistsException",
                .endpoint_group_already_exists_exception => "EndpointGroupAlreadyExistsException",
                .endpoint_group_not_found_exception => "EndpointGroupNotFoundException",
                .endpoint_not_found_exception => "EndpointNotFoundException",
                .incorrect_cidr_state_exception => "IncorrectCidrStateException",
                .internal_service_error_exception => "InternalServiceErrorException",
                .invalid_argument_exception => "InvalidArgumentException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_port_range_exception => "InvalidPortRangeException",
                .limit_exceeded_exception => "LimitExceededException",
                .listener_not_found_exception => "ListenerNotFoundException",
                .transaction_in_progress_exception => "TransactionInProgressException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .accelerator_not_disabled_exception => |e| e.message,
                .accelerator_not_found_exception => |e| e.message,
                .access_denied_exception => |e| e.message,
                .associated_endpoint_group_found_exception => |e| e.message,
                .associated_listener_found_exception => |e| e.message,
                .attachment_not_found_exception => |e| e.message,
                .byoip_cidr_not_found_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .endpoint_already_exists_exception => |e| e.message,
                .endpoint_group_already_exists_exception => |e| e.message,
                .endpoint_group_not_found_exception => |e| e.message,
                .endpoint_not_found_exception => |e| e.message,
                .incorrect_cidr_state_exception => |e| e.message,
                .internal_service_error_exception => |e| e.message,
                .invalid_argument_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_port_range_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .listener_not_found_exception => |e| e.message,
                .transaction_in_progress_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .accelerator_not_disabled_exception => 400,
                .accelerator_not_found_exception => 404,
                .access_denied_exception => 403,
                .associated_endpoint_group_found_exception => 400,
                .associated_listener_found_exception => 400,
                .attachment_not_found_exception => 404,
                .byoip_cidr_not_found_exception => 404,
                .conflict_exception => 409,
                .endpoint_already_exists_exception => 400,
                .endpoint_group_already_exists_exception => 400,
                .endpoint_group_not_found_exception => 404,
                .endpoint_not_found_exception => 404,
                .incorrect_cidr_state_exception => 404,
                .internal_service_error_exception => 500,
                .invalid_argument_exception => 400,
                .invalid_next_token_exception => 400,
                .invalid_port_range_exception => 400,
                .limit_exceeded_exception => 403,
                .listener_not_found_exception => 404,
                .transaction_in_progress_exception => 409,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .accelerator_not_disabled_exception => |e| e.request_id,
                .accelerator_not_found_exception => |e| e.request_id,
                .access_denied_exception => |e| e.request_id,
                .associated_endpoint_group_found_exception => |e| e.request_id,
                .associated_listener_found_exception => |e| e.request_id,
                .attachment_not_found_exception => |e| e.request_id,
                .byoip_cidr_not_found_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .endpoint_already_exists_exception => |e| e.request_id,
                .endpoint_group_already_exists_exception => |e| e.request_id,
                .endpoint_group_not_found_exception => |e| e.request_id,
                .endpoint_not_found_exception => |e| e.request_id,
                .incorrect_cidr_state_exception => |e| e.request_id,
                .internal_service_error_exception => |e| e.request_id,
                .invalid_argument_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_port_range_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .listener_not_found_exception => |e| e.request_id,
                .transaction_in_progress_exception => |e| e.request_id,
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

pub const AcceleratorNotDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AcceleratorNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AssociatedEndpointGroupFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AssociatedListenerFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AttachmentNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ByoipCidrNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EndpointAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EndpointGroupAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EndpointGroupNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EndpointNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IncorrectCidrStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServiceErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidArgumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPortRangeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ListenerNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TransactionInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
