const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        dnssec_limit_exceeded: DnssecLimitExceeded,
        domain_limit_exceeded: DomainLimitExceeded,
        duplicate_request: DuplicateRequest,
        invalid_input: InvalidInput,
        operation_limit_exceeded: OperationLimitExceeded,
        tld_rules_violation: TLDRulesViolation,
        unsupported_tld: UnsupportedTLD,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .dnssec_limit_exceeded => "DnssecLimitExceeded",
                .domain_limit_exceeded => "DomainLimitExceeded",
                .duplicate_request => "DuplicateRequest",
                .invalid_input => "InvalidInput",
                .operation_limit_exceeded => "OperationLimitExceeded",
                .tld_rules_violation => "TLDRulesViolation",
                .unsupported_tld => "UnsupportedTLD",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .dnssec_limit_exceeded => |e| e.message,
                .domain_limit_exceeded => |e| e.message,
                .duplicate_request => |e| e.message,
                .invalid_input => |e| e.message,
                .operation_limit_exceeded => |e| e.message,
                .tld_rules_violation => |e| e.message,
                .unsupported_tld => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .dnssec_limit_exceeded => 400,
                .domain_limit_exceeded => 400,
                .duplicate_request => 400,
                .invalid_input => 400,
                .operation_limit_exceeded => 400,
                .tld_rules_violation => 400,
                .unsupported_tld => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .dnssec_limit_exceeded => |e| e.request_id,
                .domain_limit_exceeded => |e| e.request_id,
                .duplicate_request => |e| e.request_id,
                .invalid_input => |e| e.request_id,
                .operation_limit_exceeded => |e| e.request_id,
                .tld_rules_violation => |e| e.request_id,
                .unsupported_tld => |e| e.request_id,
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

pub const DnssecLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DomainLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateRequest = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInput = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TLDRulesViolation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedTLD = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
