const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        aws_service_access_not_enabled_exception: AWSServiceAccessNotEnabledException,
        dependency_access_denied_exception: DependencyAccessDeniedException,
        illegal_argument_exception: IllegalArgumentException,
        invalid_pagination_token_exception: InvalidPaginationTokenException,
        invalid_resource_state_exception: InvalidResourceStateException,
        no_available_organization_exception: NoAvailableOrganizationException,
        no_such_resource_exception: NoSuchResourceException,
        organization_not_in_all_features_mode_exception: OrganizationNotInAllFeaturesModeException,
        quota_exceeded_exception: QuotaExceededException,
        resource_already_exists_exception: ResourceAlreadyExistsException,
        service_exception: ServiceException,
        service_quota_template_not_in_use_exception: ServiceQuotaTemplateNotInUseException,
        tag_policy_violation_exception: TagPolicyViolationException,
        templates_not_available_in_region_exception: TemplatesNotAvailableInRegionException,
        too_many_requests_exception: TooManyRequestsException,
        too_many_tags_exception: TooManyTagsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .aws_service_access_not_enabled_exception => "AWSServiceAccessNotEnabledException",
                .dependency_access_denied_exception => "DependencyAccessDeniedException",
                .illegal_argument_exception => "IllegalArgumentException",
                .invalid_pagination_token_exception => "InvalidPaginationTokenException",
                .invalid_resource_state_exception => "InvalidResourceStateException",
                .no_available_organization_exception => "NoAvailableOrganizationException",
                .no_such_resource_exception => "NoSuchResourceException",
                .organization_not_in_all_features_mode_exception => "OrganizationNotInAllFeaturesModeException",
                .quota_exceeded_exception => "QuotaExceededException",
                .resource_already_exists_exception => "ResourceAlreadyExistsException",
                .service_exception => "ServiceException",
                .service_quota_template_not_in_use_exception => "ServiceQuotaTemplateNotInUseException",
                .tag_policy_violation_exception => "TagPolicyViolationException",
                .templates_not_available_in_region_exception => "TemplatesNotAvailableInRegionException",
                .too_many_requests_exception => "TooManyRequestsException",
                .too_many_tags_exception => "TooManyTagsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .aws_service_access_not_enabled_exception => |e| e.message,
                .dependency_access_denied_exception => |e| e.message,
                .illegal_argument_exception => |e| e.message,
                .invalid_pagination_token_exception => |e| e.message,
                .invalid_resource_state_exception => |e| e.message,
                .no_available_organization_exception => |e| e.message,
                .no_such_resource_exception => |e| e.message,
                .organization_not_in_all_features_mode_exception => |e| e.message,
                .quota_exceeded_exception => |e| e.message,
                .resource_already_exists_exception => |e| e.message,
                .service_exception => |e| e.message,
                .service_quota_template_not_in_use_exception => |e| e.message,
                .tag_policy_violation_exception => |e| e.message,
                .templates_not_available_in_region_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .aws_service_access_not_enabled_exception => 403,
                .dependency_access_denied_exception => 403,
                .illegal_argument_exception => 400,
                .invalid_pagination_token_exception => 400,
                .invalid_resource_state_exception => 405,
                .no_available_organization_exception => 403,
                .no_such_resource_exception => 404,
                .organization_not_in_all_features_mode_exception => 400,
                .quota_exceeded_exception => 409,
                .resource_already_exists_exception => 400,
                .service_exception => 500,
                .service_quota_template_not_in_use_exception => 400,
                .tag_policy_violation_exception => 401,
                .templates_not_available_in_region_exception => 404,
                .too_many_requests_exception => 429,
                .too_many_tags_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .aws_service_access_not_enabled_exception => |e| e.request_id,
                .dependency_access_denied_exception => |e| e.request_id,
                .illegal_argument_exception => |e| e.request_id,
                .invalid_pagination_token_exception => |e| e.request_id,
                .invalid_resource_state_exception => |e| e.request_id,
                .no_available_organization_exception => |e| e.request_id,
                .no_such_resource_exception => |e| e.request_id,
                .organization_not_in_all_features_mode_exception => |e| e.request_id,
                .quota_exceeded_exception => |e| e.request_id,
                .resource_already_exists_exception => |e| e.request_id,
                .service_exception => |e| e.request_id,
                .service_quota_template_not_in_use_exception => |e| e.request_id,
                .tag_policy_violation_exception => |e| e.request_id,
                .templates_not_available_in_region_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
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

/// You do not have sufficient permission to perform this action.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The action you attempted is not allowed unless Service Access with Service
/// Quotas is enabled in
/// your organization.
pub const AWSServiceAccessNotEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You can't perform this action because a dependency does not have access.
pub const DependencyAccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Invalid input was provided.
pub const IllegalArgumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Invalid input was provided.
pub const InvalidPaginationTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource is in an invalid state.
pub const InvalidResourceStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The Amazon Web Services account making this call is not a member of an
/// organization.
pub const NoAvailableOrganizationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified resource does not exist.
pub const NoSuchResourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The organization that your Amazon Web Services account belongs to is not in
/// All Features
/// mode.
pub const OrganizationNotInAllFeaturesModeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You have exceeded your service quota. To perform the requested action,
/// remove some of
/// the relevant resources, or use Service Quotas to request a service quota
/// increase.
pub const QuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified resource already exists.
pub const ResourceAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Something went wrong.
pub const ServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The quota request template is not associated with your organization.
pub const ServiceQuotaTemplateNotInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified tag is a reserved word and cannot be used.
pub const TagPolicyViolationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The Service Quotas template is not available in this Amazon Web Services
/// Region.
pub const TemplatesNotAvailableInRegionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Due to throttling, the request was denied. Slow down the rate of request
/// calls, or
/// request an increase for this quota.
pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You've exceeded the number of tags allowed for a resource. For more
/// information, see
/// [Tag
/// restrictions](https://docs.aws.amazon.com/servicequotas/latest/userguide/sq-tagging.html#sq-tagging-restrictions) in the *Service Quotas User Guide*.
pub const TooManyTagsException = struct {
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
