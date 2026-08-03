const std = @import("std");

const ConflictingItem = @import("conflicting_item.zig").ConflictingItem;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        conflict_exception: ConflictException,
        featured_results_conflict_exception: FeaturedResultsConflictException,
        internal_server_exception: InternalServerException,
        invalid_request_exception: InvalidRequestException,
        resource_already_exist_exception: ResourceAlreadyExistException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_found_exception: ResourceNotFoundException,
        resource_unavailable_exception: ResourceUnavailableException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        throttling_exception: ThrottlingException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .conflict_exception => "ConflictException",
                .featured_results_conflict_exception => "FeaturedResultsConflictException",
                .internal_server_exception => "InternalServerException",
                .invalid_request_exception => "InvalidRequestException",
                .resource_already_exist_exception => "ResourceAlreadyExistException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .resource_unavailable_exception => "ResourceUnavailableException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .throttling_exception => "ThrottlingException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .featured_results_conflict_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .resource_already_exist_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .resource_unavailable_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .conflict_exception => 409,
                .featured_results_conflict_exception => 409,
                .internal_server_exception => 500,
                .invalid_request_exception => 400,
                .resource_already_exist_exception => 400,
                .resource_in_use_exception => 400,
                .resource_not_found_exception => 404,
                .resource_unavailable_exception => 404,
                .service_quota_exceeded_exception => 402,
                .throttling_exception => 429,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .featured_results_conflict_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .resource_already_exist_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .resource_unavailable_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .validation_exception => |e| e.request_id,
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

/// You don't have sufficient access to perform this action. Please ensure you
/// have the
/// required permission policies and user accounts and try again.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A conflict occurred with the request. Please fix any inconsistences with
/// your
/// resources and try again.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An error message with a list of conflicting queries used across different
/// sets
/// of featured results. This occurred with the request for a new featured
/// results set.
/// Check that the queries you specified for featured results are unique per
/// featured
/// results set for each index.
pub const FeaturedResultsConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// A list of the conflicting queries, including the query text, the name for
    /// the featured results set, and the identifier of the featured results set.
    conflicting_items: ?[]const ConflictingItem = null,

    pub const json_field_names = .{
        .conflicting_items = "ConflictingItems",
        .message = "Message",
    };
};

/// An issue occurred with the internal server used for your Amazon Kendra
/// service.
/// Please wait a few minutes and try again, or contact
/// [Support](http://aws.amazon.com/contact-us/) for help.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The input to the request is not valid. Please provide the correct input and
/// try
/// again.
pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource you want to use already exists. Please check you have provided
/// the
/// correct resource and try again.
pub const ResourceAlreadyExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource you want to use is currently in use. Please check you have
/// provided the
/// correct resource and try again.
pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource you want to use doesn’t exist. Please check you have provided
/// the correct
/// resource and try again.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource you want to use isn't available. Please check you have provided
/// the
/// correct resource and try again.
pub const ResourceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You have exceeded the set limits for your Amazon Kendra service. Please see
/// [Quotas](https://docs.aws.amazon.com/kendra/latest/dg/quotas.html) for
/// more information, or contact [Support](http://aws.amazon.com/contact-us/) to
/// inquire about
/// an increase of limits.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was denied due to request throttling. Please reduce the number
/// of requests
/// and try again.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The input fails to satisfy the constraints set by the Amazon Kendra service.
/// Please provide the correct input and try again.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
