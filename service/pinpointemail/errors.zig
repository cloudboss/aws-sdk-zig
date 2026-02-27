const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        account_suspended_exception: AccountSuspendedException,
        already_exists_exception: AlreadyExistsException,
        bad_request_exception: BadRequestException,
        concurrent_modification_exception: ConcurrentModificationException,
        limit_exceeded_exception: LimitExceededException,
        mail_from_domain_not_verified_exception: MailFromDomainNotVerifiedException,
        message_rejected: MessageRejected,
        not_found_exception: NotFoundException,
        sending_paused_exception: SendingPausedException,
        too_many_requests_exception: TooManyRequestsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .account_suspended_exception => "AccountSuspendedException",
                .already_exists_exception => "AlreadyExistsException",
                .bad_request_exception => "BadRequestException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .limit_exceeded_exception => "LimitExceededException",
                .mail_from_domain_not_verified_exception => "MailFromDomainNotVerifiedException",
                .message_rejected => "MessageRejected",
                .not_found_exception => "NotFoundException",
                .sending_paused_exception => "SendingPausedException",
                .too_many_requests_exception => "TooManyRequestsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .account_suspended_exception => |e| e.message,
                .already_exists_exception => |e| e.message,
                .bad_request_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .mail_from_domain_not_verified_exception => |e| e.message,
                .message_rejected => |e| e.message,
                .not_found_exception => |e| e.message,
                .sending_paused_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .account_suspended_exception => 400,
                .already_exists_exception => 400,
                .bad_request_exception => 400,
                .concurrent_modification_exception => 500,
                .limit_exceeded_exception => 400,
                .mail_from_domain_not_verified_exception => 400,
                .message_rejected => 400,
                .not_found_exception => 404,
                .sending_paused_exception => 400,
                .too_many_requests_exception => 429,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .account_suspended_exception => |e| e.request_id,
                .already_exists_exception => |e| e.request_id,
                .bad_request_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .mail_from_domain_not_verified_exception => |e| e.request_id,
                .message_rejected => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .sending_paused_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
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

pub const AccountSuspendedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BadRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MailFromDomainNotVerifiedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MessageRejected = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SendingPausedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
