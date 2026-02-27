const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        attachment_id_not_found: AttachmentIdNotFound,
        attachment_limit_exceeded: AttachmentLimitExceeded,
        attachment_set_expired: AttachmentSetExpired,
        attachment_set_id_not_found: AttachmentSetIdNotFound,
        attachment_set_size_limit_exceeded: AttachmentSetSizeLimitExceeded,
        case_creation_limit_exceeded: CaseCreationLimitExceeded,
        case_id_not_found: CaseIdNotFound,
        describe_attachment_limit_exceeded: DescribeAttachmentLimitExceeded,
        internal_server_error: InternalServerError,
        throttling_exception: ThrottlingException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .attachment_id_not_found => "AttachmentIdNotFound",
                .attachment_limit_exceeded => "AttachmentLimitExceeded",
                .attachment_set_expired => "AttachmentSetExpired",
                .attachment_set_id_not_found => "AttachmentSetIdNotFound",
                .attachment_set_size_limit_exceeded => "AttachmentSetSizeLimitExceeded",
                .case_creation_limit_exceeded => "CaseCreationLimitExceeded",
                .case_id_not_found => "CaseIdNotFound",
                .describe_attachment_limit_exceeded => "DescribeAttachmentLimitExceeded",
                .internal_server_error => "InternalServerError",
                .throttling_exception => "ThrottlingException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .attachment_id_not_found => |e| e.message,
                .attachment_limit_exceeded => |e| e.message,
                .attachment_set_expired => |e| e.message,
                .attachment_set_id_not_found => |e| e.message,
                .attachment_set_size_limit_exceeded => |e| e.message,
                .case_creation_limit_exceeded => |e| e.message,
                .case_id_not_found => |e| e.message,
                .describe_attachment_limit_exceeded => |e| e.message,
                .internal_server_error => |e| e.message,
                .throttling_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .attachment_id_not_found => 400,
                .attachment_limit_exceeded => 400,
                .attachment_set_expired => 400,
                .attachment_set_id_not_found => 400,
                .attachment_set_size_limit_exceeded => 400,
                .case_creation_limit_exceeded => 400,
                .case_id_not_found => 400,
                .describe_attachment_limit_exceeded => 400,
                .internal_server_error => 500,
                .throttling_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .attachment_id_not_found => |e| e.request_id,
                .attachment_limit_exceeded => |e| e.request_id,
                .attachment_set_expired => |e| e.request_id,
                .attachment_set_id_not_found => |e| e.request_id,
                .attachment_set_size_limit_exceeded => |e| e.request_id,
                .case_creation_limit_exceeded => |e| e.request_id,
                .case_id_not_found => |e| e.request_id,
                .describe_attachment_limit_exceeded => |e| e.request_id,
                .internal_server_error => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
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

pub const AttachmentIdNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AttachmentLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AttachmentSetExpired = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AttachmentSetIdNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AttachmentSetSizeLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CaseCreationLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CaseIdNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DescribeAttachmentLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
