const std = @import("std");

const ValidationExceptionField = @import("validation_exception_field.zig").ValidationExceptionField;
const ValidationExceptionReason = @import("validation_exception_reason.zig").ValidationExceptionReason;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        access_denied_for_dependency_exception: AccessDeniedForDependencyException,
        internal_error_exception: InternalErrorException,
        invalid_operation_exception: InvalidOperationException,
        invalid_pagination_token_exception: InvalidPaginationTokenException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_resource_exception: InvalidResourceException,
        limits_exceeded_exception: LimitsExceededException,
        locked_subscription_exception: LockedSubscriptionException,
        no_associated_role_exception: NoAssociatedRoleException,
        optimistic_lock_exception: OptimisticLockException,
        resource_already_exists_exception: ResourceAlreadyExistsException,
        resource_not_found_exception: ResourceNotFoundException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .access_denied_for_dependency_exception => "AccessDeniedForDependencyException",
                .internal_error_exception => "InternalErrorException",
                .invalid_operation_exception => "InvalidOperationException",
                .invalid_pagination_token_exception => "InvalidPaginationTokenException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_resource_exception => "InvalidResourceException",
                .limits_exceeded_exception => "LimitsExceededException",
                .locked_subscription_exception => "LockedSubscriptionException",
                .no_associated_role_exception => "NoAssociatedRoleException",
                .optimistic_lock_exception => "OptimisticLockException",
                .resource_already_exists_exception => "ResourceAlreadyExistsException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .access_denied_for_dependency_exception => |e| e.message,
                .internal_error_exception => |e| e.message,
                .invalid_operation_exception => |e| e.message,
                .invalid_pagination_token_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_resource_exception => |e| e.message,
                .limits_exceeded_exception => |e| e.message,
                .locked_subscription_exception => |e| e.message,
                .no_associated_role_exception => |e| e.message,
                .optimistic_lock_exception => |e| e.message,
                .resource_already_exists_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 400,
                .access_denied_for_dependency_exception => 400,
                .internal_error_exception => 500,
                .invalid_operation_exception => 400,
                .invalid_pagination_token_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_resource_exception => 400,
                .limits_exceeded_exception => 400,
                .locked_subscription_exception => 400,
                .no_associated_role_exception => 400,
                .optimistic_lock_exception => 400,
                .resource_already_exists_exception => 400,
                .resource_not_found_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .access_denied_for_dependency_exception => |e| e.request_id,
                .internal_error_exception => |e| e.request_id,
                .invalid_operation_exception => |e| e.request_id,
                .invalid_pagination_token_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_resource_exception => |e| e.request_id,
                .limits_exceeded_exception => |e| e.request_id,
                .locked_subscription_exception => |e| e.request_id,
                .no_associated_role_exception => |e| e.request_id,
                .optimistic_lock_exception => |e| e.request_id,
                .resource_already_exists_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
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

/// Exception that indicates the specified `AttackId` does not exist, or the
/// requester does not have the appropriate permissions to access the
/// `AttackId`.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// In order to grant the necessary access to the Shield Response Team (SRT) the
/// user submitting the request must have the `iam:PassRole` permission. This
/// error indicates the user did not have the appropriate permissions. For more
/// information, see [Granting a User Permissions to Pass a Role to an Amazon
/// Web Services
/// Service](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_passrole.html).
pub const AccessDeniedForDependencyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Exception that indicates that a problem occurred with the service
/// infrastructure. You can retry the request.
pub const InternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Exception that indicates that the operation would not cause any change to
/// occur.
pub const InvalidOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Exception that indicates that the `NextToken` specified in the request is
/// invalid. Submit the request using the `NextToken` value that was returned in
/// the prior response.
pub const InvalidPaginationTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Exception that indicates that the parameters passed to the API are invalid.
/// If available, this exception includes details in additional properties.
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Fields that caused the exception.
    fields: ?[]const ValidationExceptionField = null,

    /// Additional information about the exception.
    reason: ?ValidationExceptionReason = null,

    pub const json_field_names = .{
        .fields = "fields",
        .message = "message",
        .reason = "reason",
    };
};

/// Exception that indicates that the resource is invalid. You might not have
/// access to the resource, or the resource might not exist.
pub const InvalidResourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Exception that indicates that the operation would exceed a limit.
pub const LimitsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The threshold that would be exceeded.
    limit: ?i64 = null,

    /// The type of limit that would be exceeded.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .limit = "Limit",
        .message = "message",
        .@"type" = "Type",
    };
};

/// You are trying to update a subscription that has not yet completed the
/// 1-year commitment. You can change the `AutoRenew` parameter during the last
/// 30 days of your subscription. This exception indicates that you are
/// attempting to change `AutoRenew` prior to that period.
pub const LockedSubscriptionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The ARN of the role that you specified does not exist.
pub const NoAssociatedRoleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Exception that indicates that the resource state has been modified by
/// another
/// client. Retrieve the resource and then retry your request.
pub const OptimisticLockException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Exception indicating the specified resource already exists. If available,
/// this exception includes details in additional properties.
pub const ResourceAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The type of resource that already exists.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .resource_type = "resourceType",
    };
};

/// Exception indicating the specified resource does not exist. If available,
/// this exception includes details in additional properties.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Type of resource.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .resource_type = "resourceType",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
