const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        bad_request_exception: BadRequestException,
        cluster_connectivity_exception: ClusterConnectivityException,
        conflict_exception: ConflictException,
        controller_moved_exception: ControllerMovedException,
        forbidden_exception: ForbiddenException,
        group_subscribed_to_topic_exception: GroupSubscribedToTopicException,
        internal_server_error_exception: InternalServerErrorException,
        kafka_request_exception: KafkaRequestException,
        kafka_timeout_exception: KafkaTimeoutException,
        not_controller_exception: NotControllerException,
        not_found_exception: NotFoundException,
        reassignment_in_progress_exception: ReassignmentInProgressException,
        service_unavailable_exception: ServiceUnavailableException,
        too_many_requests_exception: TooManyRequestsException,
        topic_exists_exception: TopicExistsException,
        unauthorized_exception: UnauthorizedException,
        unknown_topic_or_partition_exception: UnknownTopicOrPartitionException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => "BadRequestException",
                .cluster_connectivity_exception => "ClusterConnectivityException",
                .conflict_exception => "ConflictException",
                .controller_moved_exception => "ControllerMovedException",
                .forbidden_exception => "ForbiddenException",
                .group_subscribed_to_topic_exception => "GroupSubscribedToTopicException",
                .internal_server_error_exception => "InternalServerErrorException",
                .kafka_request_exception => "KafkaRequestException",
                .kafka_timeout_exception => "KafkaTimeoutException",
                .not_controller_exception => "NotControllerException",
                .not_found_exception => "NotFoundException",
                .reassignment_in_progress_exception => "ReassignmentInProgressException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .too_many_requests_exception => "TooManyRequestsException",
                .topic_exists_exception => "TopicExistsException",
                .unauthorized_exception => "UnauthorizedException",
                .unknown_topic_or_partition_exception => "UnknownTopicOrPartitionException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => |e| e.message,
                .cluster_connectivity_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .controller_moved_exception => |e| e.message,
                .forbidden_exception => |e| e.message,
                .group_subscribed_to_topic_exception => |e| e.message,
                .internal_server_error_exception => |e| e.message,
                .kafka_request_exception => |e| e.message,
                .kafka_timeout_exception => |e| e.message,
                .not_controller_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .reassignment_in_progress_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .topic_exists_exception => |e| e.message,
                .unauthorized_exception => |e| e.message,
                .unknown_topic_or_partition_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .bad_request_exception => 400,
                .cluster_connectivity_exception => 409,
                .conflict_exception => 409,
                .controller_moved_exception => 409,
                .forbidden_exception => 403,
                .group_subscribed_to_topic_exception => 409,
                .internal_server_error_exception => 500,
                .kafka_request_exception => 400,
                .kafka_timeout_exception => 409,
                .not_controller_exception => 409,
                .not_found_exception => 404,
                .reassignment_in_progress_exception => 409,
                .service_unavailable_exception => 503,
                .too_many_requests_exception => 429,
                .topic_exists_exception => 409,
                .unauthorized_exception => 401,
                .unknown_topic_or_partition_exception => 404,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => |e| e.request_id,
                .cluster_connectivity_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .controller_moved_exception => |e| e.request_id,
                .forbidden_exception => |e| e.request_id,
                .group_subscribed_to_topic_exception => |e| e.request_id,
                .internal_server_error_exception => |e| e.request_id,
                .kafka_request_exception => |e| e.request_id,
                .kafka_timeout_exception => |e| e.request_id,
                .not_controller_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .reassignment_in_progress_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
                .topic_exists_exception => |e| e.request_id,
                .unauthorized_exception => |e| e.request_id,
                .unknown_topic_or_partition_exception => |e| e.request_id,
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

pub const BadRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterConnectivityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ControllerMovedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ForbiddenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GroupSubscribedToTopicException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KafkaRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KafkaTimeoutException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotControllerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReassignmentInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TopicExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnauthorizedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownTopicOrPartitionException = struct {
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterConnectivityException")) {
        return .{ .arena = arena, .kind = .{ .cluster_connectivity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ControllerMovedException")) {
        return .{ .arena = arena, .kind = .{ .controller_moved_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GroupSubscribedToTopicException")) {
        return .{ .arena = arena, .kind = .{ .group_subscribed_to_topic_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KafkaRequestException")) {
        return .{ .arena = arena, .kind = .{ .kafka_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KafkaTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .kafka_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotControllerException")) {
        return .{ .arena = arena, .kind = .{ .not_controller_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReassignmentInProgressException")) {
        return .{ .arena = arena, .kind = .{ .reassignment_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TopicExistsException")) {
        return .{ .arena = arena, .kind = .{ .topic_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnknownTopicOrPartitionException")) {
        return .{ .arena = arena, .kind = .{ .unknown_topic_or_partition_exception = .{
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
