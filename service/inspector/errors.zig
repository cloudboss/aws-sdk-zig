const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        agents_already_running_assessment_exception: AgentsAlreadyRunningAssessmentException,
        assessment_run_in_progress_exception: AssessmentRunInProgressException,
        internal_exception: InternalException,
        invalid_cross_account_role_exception: InvalidCrossAccountRoleException,
        invalid_input_exception: InvalidInputException,
        limit_exceeded_exception: LimitExceededException,
        no_such_entity_exception: NoSuchEntityException,
        preview_generation_in_progress_exception: PreviewGenerationInProgressException,
        service_temporarily_unavailable_exception: ServiceTemporarilyUnavailableException,
        unsupported_feature_exception: UnsupportedFeatureException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .agents_already_running_assessment_exception => "AgentsAlreadyRunningAssessmentException",
                .assessment_run_in_progress_exception => "AssessmentRunInProgressException",
                .internal_exception => "InternalException",
                .invalid_cross_account_role_exception => "InvalidCrossAccountRoleException",
                .invalid_input_exception => "InvalidInputException",
                .limit_exceeded_exception => "LimitExceededException",
                .no_such_entity_exception => "NoSuchEntityException",
                .preview_generation_in_progress_exception => "PreviewGenerationInProgressException",
                .service_temporarily_unavailable_exception => "ServiceTemporarilyUnavailableException",
                .unsupported_feature_exception => "UnsupportedFeatureException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .agents_already_running_assessment_exception => |e| e.message,
                .assessment_run_in_progress_exception => |e| e.message,
                .internal_exception => |e| e.message,
                .invalid_cross_account_role_exception => |e| e.message,
                .invalid_input_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .no_such_entity_exception => |e| e.message,
                .preview_generation_in_progress_exception => |e| e.message,
                .service_temporarily_unavailable_exception => |e| e.message,
                .unsupported_feature_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .agents_already_running_assessment_exception => 400,
                .assessment_run_in_progress_exception => 400,
                .internal_exception => 500,
                .invalid_cross_account_role_exception => 400,
                .invalid_input_exception => 400,
                .limit_exceeded_exception => 400,
                .no_such_entity_exception => 400,
                .preview_generation_in_progress_exception => 400,
                .service_temporarily_unavailable_exception => 503,
                .unsupported_feature_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .agents_already_running_assessment_exception => |e| e.request_id,
                .assessment_run_in_progress_exception => |e| e.request_id,
                .internal_exception => |e| e.request_id,
                .invalid_cross_account_role_exception => |e| e.request_id,
                .invalid_input_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .no_such_entity_exception => |e| e.request_id,
                .preview_generation_in_progress_exception => |e| e.request_id,
                .service_temporarily_unavailable_exception => |e| e.request_id,
                .unsupported_feature_exception => |e| e.request_id,
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

pub const AgentsAlreadyRunningAssessmentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AssessmentRunInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCrossAccountRoleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchEntityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PreviewGenerationInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceTemporarilyUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedFeatureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
