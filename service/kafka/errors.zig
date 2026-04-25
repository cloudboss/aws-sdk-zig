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
