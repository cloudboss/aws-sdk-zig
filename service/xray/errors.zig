const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        invalid_policy_revision_id_exception: InvalidPolicyRevisionIdException,
        invalid_request_exception: InvalidRequestException,
        lockout_prevention_exception: LockoutPreventionException,
        malformed_policy_document_exception: MalformedPolicyDocumentException,
        policy_count_limit_exceeded_exception: PolicyCountLimitExceededException,
        policy_size_limit_exceeded_exception: PolicySizeLimitExceededException,
        resource_not_found_exception: ResourceNotFoundException,
        rule_limit_exceeded_exception: RuleLimitExceededException,
        throttled_exception: ThrottledException,
        too_many_tags_exception: TooManyTagsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .invalid_policy_revision_id_exception => "InvalidPolicyRevisionIdException",
                .invalid_request_exception => "InvalidRequestException",
                .lockout_prevention_exception => "LockoutPreventionException",
                .malformed_policy_document_exception => "MalformedPolicyDocumentException",
                .policy_count_limit_exceeded_exception => "PolicyCountLimitExceededException",
                .policy_size_limit_exceeded_exception => "PolicySizeLimitExceededException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .rule_limit_exceeded_exception => "RuleLimitExceededException",
                .throttled_exception => "ThrottledException",
                .too_many_tags_exception => "TooManyTagsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .invalid_policy_revision_id_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .lockout_prevention_exception => |e| e.message,
                .malformed_policy_document_exception => |e| e.message,
                .policy_count_limit_exceeded_exception => |e| e.message,
                .policy_size_limit_exceeded_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .rule_limit_exceeded_exception => |e| e.message,
                .throttled_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .invalid_policy_revision_id_exception => 400,
                .invalid_request_exception => 400,
                .lockout_prevention_exception => 400,
                .malformed_policy_document_exception => 400,
                .policy_count_limit_exceeded_exception => 400,
                .policy_size_limit_exceeded_exception => 400,
                .resource_not_found_exception => 404,
                .rule_limit_exceeded_exception => 400,
                .throttled_exception => 429,
                .too_many_tags_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .invalid_policy_revision_id_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .lockout_prevention_exception => |e| e.request_id,
                .malformed_policy_document_exception => |e| e.request_id,
                .policy_count_limit_exceeded_exception => |e| e.request_id,
                .policy_size_limit_exceeded_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .rule_limit_exceeded_exception => |e| e.request_id,
                .throttled_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
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

pub const InvalidPolicyRevisionIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LockoutPreventionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MalformedPolicyDocumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicyCountLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicySizeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RuleLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
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

    if (std.mem.eql(u8, error_code, "InvalidPolicyRevisionIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_revision_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LockoutPreventionException")) {
        return .{ .arena = arena, .kind = .{ .lockout_prevention_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyDocumentException")) {
        return .{ .arena = arena, .kind = .{ .malformed_policy_document_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyCountLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .policy_count_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicySizeLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .policy_size_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RuleLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .rule_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .throttled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
