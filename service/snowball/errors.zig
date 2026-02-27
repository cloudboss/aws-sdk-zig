const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        cluster_limit_exceeded_exception: ClusterLimitExceededException,
        conflict_exception: ConflictException,
        ec_2_request_failed_exception: Ec2RequestFailedException,
        invalid_address_exception: InvalidAddressException,
        invalid_input_combination_exception: InvalidInputCombinationException,
        invalid_job_state_exception: InvalidJobStateException,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_resource_exception: InvalidResourceException,
        kms_request_failed_exception: KMSRequestFailedException,
        return_shipping_label_already_exists_exception: ReturnShippingLabelAlreadyExistsException,
        unsupported_address_exception: UnsupportedAddressException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .cluster_limit_exceeded_exception => "ClusterLimitExceededException",
                .conflict_exception => "ConflictException",
                .ec_2_request_failed_exception => "Ec2RequestFailedException",
                .invalid_address_exception => "InvalidAddressException",
                .invalid_input_combination_exception => "InvalidInputCombinationException",
                .invalid_job_state_exception => "InvalidJobStateException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_resource_exception => "InvalidResourceException",
                .kms_request_failed_exception => "KMSRequestFailedException",
                .return_shipping_label_already_exists_exception => "ReturnShippingLabelAlreadyExistsException",
                .unsupported_address_exception => "UnsupportedAddressException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .cluster_limit_exceeded_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .ec_2_request_failed_exception => |e| e.message,
                .invalid_address_exception => |e| e.message,
                .invalid_input_combination_exception => |e| e.message,
                .invalid_job_state_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_resource_exception => |e| e.message,
                .kms_request_failed_exception => |e| e.message,
                .return_shipping_label_already_exists_exception => |e| e.message,
                .unsupported_address_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .cluster_limit_exceeded_exception => 400,
                .conflict_exception => 400,
                .ec_2_request_failed_exception => 400,
                .invalid_address_exception => 400,
                .invalid_input_combination_exception => 400,
                .invalid_job_state_exception => 400,
                .invalid_next_token_exception => 400,
                .invalid_resource_exception => 400,
                .kms_request_failed_exception => 400,
                .return_shipping_label_already_exists_exception => 400,
                .unsupported_address_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .cluster_limit_exceeded_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .ec_2_request_failed_exception => |e| e.request_id,
                .invalid_address_exception => |e| e.request_id,
                .invalid_input_combination_exception => |e| e.request_id,
                .invalid_job_state_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_resource_exception => |e| e.request_id,
                .kms_request_failed_exception => |e| e.request_id,
                .return_shipping_label_already_exists_exception => |e| e.request_id,
                .unsupported_address_exception => |e| e.request_id,
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

pub const ClusterLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const Ec2RequestFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAddressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInputCombinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidJobStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidResourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSRequestFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReturnShippingLabelAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedAddressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
