const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        conflict_exception: ConflictException,
        internal_service_error_exception: InternalServiceErrorException,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_policy_document: InvalidPolicyDocument,
        invalid_request_exception: InvalidRequestException,
        invalid_tag_exception: InvalidTagException,
        limit_exceeded_exception: LimitExceededException,
        resource_exists_exception: ResourceExistsException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_found_exception: ResourceNotFoundException,
        resource_unavailable_exception: ResourceUnavailableException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        throttling_exception: ThrottlingException,
        unknown_resource_exception: UnknownResourceException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .conflict_exception => "ConflictException",
                .internal_service_error_exception => "InternalServiceErrorException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_policy_document => "InvalidPolicyDocument",
                .invalid_request_exception => "InvalidRequestException",
                .invalid_tag_exception => "InvalidTagException",
                .limit_exceeded_exception => "LimitExceededException",
                .resource_exists_exception => "ResourceExistsException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .resource_unavailable_exception => "ResourceUnavailableException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .throttling_exception => "ThrottlingException",
                .unknown_resource_exception => "UnknownResourceException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .internal_service_error_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_policy_document => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .invalid_tag_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .resource_exists_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .resource_unavailable_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unknown_resource_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 400,
                .conflict_exception => 400,
                .internal_service_error_exception => 400,
                .invalid_next_token_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_policy_document => 400,
                .invalid_request_exception => 400,
                .invalid_tag_exception => 400,
                .limit_exceeded_exception => 400,
                .resource_exists_exception => 400,
                .resource_in_use_exception => 400,
                .resource_not_found_exception => 400,
                .resource_unavailable_exception => 400,
                .service_quota_exceeded_exception => 400,
                .throttling_exception => 400,
                .unknown_resource_exception => 400,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .internal_service_error_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_policy_document => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .invalid_tag_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .resource_exists_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .resource_unavailable_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .unknown_resource_exception => |e| e.request_id,
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

/// The current account doesn't have the IAM permissions required to perform the
/// specified Resolver operation.
///
/// This error can also be thrown when a customer has reached the 5120 character
/// limit for a
/// resource policy for CloudWatch Logs.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The requested state transition isn't valid. For example, you can't delete a
/// firewall
/// domain list if it is in the process of being deleted, or you can't import
/// domains into a
/// domain list that is in the process of being deleted.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// We encountered an unknown error. Try again in a few minutes.
pub const InternalServiceErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The value that you specified for `NextToken` in a `List` request isn't
/// valid.
pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// One or more parameters in this request are not valid.
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// For an `InvalidParameterException` error, the name of the parameter that's
    /// invalid.
    field_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .message = "Message",
    };
};

/// The specified Resolver rule policy is invalid.
pub const InvalidPolicyDocument = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request is invalid.
pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified tag is invalid.
pub const InvalidTagException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request caused one or more limits to be exceeded.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// For a `LimitExceededException` error, the type of resource that exceeded the
    /// current limit.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .resource_type = "ResourceType",
    };
};

/// The resource that you tried to create already exists.
pub const ResourceExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// For a `ResourceExistsException` error, the type of resource that the error
    /// applies to.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .resource_type = "ResourceType",
    };
};

/// The resource that you tried to update or delete is currently in use.
pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// For a `ResourceInUseException` error, the type of resource that is currently
    /// in use.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .resource_type = "ResourceType",
    };
};

/// The specified resource doesn't exist.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// For a `ResourceNotFoundException` error, the type of resource that doesn't
    /// exist.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .resource_type = "ResourceType",
    };
};

/// The specified resource isn't available.
pub const ResourceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// For a `ResourceUnavailableException` error, the type of resource that isn't
    /// available.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .resource_type = "ResourceType",
    };
};

/// Fulfilling the request would cause one or more quotas to be exceeded.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was throttled. Try again in a few minutes.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified resource doesn't exist.
pub const UnknownResourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You have provided an invalid command. If you ran the `UpdateFirewallDomains`
/// request. supported values are `ADD`,
/// `REMOVE`, or `REPLACE` a domain.
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
