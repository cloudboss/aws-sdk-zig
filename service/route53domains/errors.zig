const aws = @import("aws");
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
        tld_in_maintenance: TLDInMaintenance,
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
                .tld_in_maintenance => "TLDInMaintenance",
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
                .tld_in_maintenance => |e| e.message,
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
                .tld_in_maintenance => 400,
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
                .tld_in_maintenance => |e| e.request_id,
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

/// This error is returned if you call `AssociateDelegationSignerToDomain`
/// when the specified domain has reached the maximum number of DS records. You
/// can't add
/// any additional DS records unless you delete an existing one first.
pub const DnssecLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The number of domains has exceeded the allowed threshold for the account.
pub const DomainLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request is already in progress for the domain.
pub const DuplicateRequest = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
        .request_id = "requestId",
    };
};

/// The requested item is not acceptable. For example, for APIs that accept a
/// domain name,
/// the request might specify a domain name that doesn't belong to the account
/// that
/// submitted the request. For `AcceptDomainTransferFromAnotherAwsAccount`, the
/// password might be invalid.
pub const InvalidInput = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The number of operations or jobs running exceeded the allowed threshold for
/// the
/// account.
pub const OperationLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The top-level domain is currently undergoing maintenance and the request
/// cannot be processed. Try again later.
pub const TLDInMaintenance = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The top-level domain that is currently undergoing maintenance.
    tld: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .tld = "tld",
    };
};

/// The top-level domain does not support this operation.
pub const TLDRulesViolation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Amazon Route 53 does not support this top-level domain (TLD).
pub const UnsupportedTLD = struct {
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

    if (std.mem.eql(u8, error_code, "DnssecLimitExceeded")) {
        const parsed_error: ?DnssecLimitExceeded = aws.json.parseJsonObject(DnssecLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .dnssec_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DomainLimitExceeded")) {
        const parsed_error: ?DomainLimitExceeded = aws.json.parseJsonObject(DomainLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .domain_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateRequest")) {
        const parsed_error: ?DuplicateRequest = aws.json.parseJsonObject(DuplicateRequest, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_request = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInput")) {
        const parsed_error: ?InvalidInput = aws.json.parseJsonObject(InvalidInput, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_input = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OperationLimitExceeded")) {
        const parsed_error: ?OperationLimitExceeded = aws.json.parseJsonObject(OperationLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .operation_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TLDInMaintenance")) {
        const parsed_error: ?TLDInMaintenance = aws.json.parseJsonObject(TLDInMaintenance, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tld_in_maintenance = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TLDRulesViolation")) {
        const parsed_error: ?TLDRulesViolation = aws.json.parseJsonObject(TLDRulesViolation, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tld_rules_violation = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedTLD")) {
        const parsed_error: ?UnsupportedTLD = aws.json.parseJsonObject(UnsupportedTLD, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_tld = typed_error } };
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
