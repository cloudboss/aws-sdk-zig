const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        directory_in_use_exception: DirectoryInUseException,
        directory_service_authentication_failed_exception: DirectoryServiceAuthenticationFailedException,
        directory_unavailable_exception: DirectoryUnavailableException,
        email_address_in_use_exception: EmailAddressInUseException,
        entity_already_registered_exception: EntityAlreadyRegisteredException,
        entity_not_found_exception: EntityNotFoundException,
        entity_state_exception: EntityStateException,
        invalid_configuration_exception: InvalidConfigurationException,
        invalid_custom_ses_configuration_exception: InvalidCustomSesConfigurationException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_password_exception: InvalidPasswordException,
        limit_exceeded_exception: LimitExceededException,
        mail_domain_in_use_exception: MailDomainInUseException,
        mail_domain_not_found_exception: MailDomainNotFoundException,
        mail_domain_state_exception: MailDomainStateException,
        name_availability_exception: NameAvailabilityException,
        organization_not_found_exception: OrganizationNotFoundException,
        organization_state_exception: OrganizationStateException,
        reserved_name_exception: ReservedNameException,
        resource_not_found_exception: ResourceNotFoundException,
        too_many_tags_exception: TooManyTagsException,
        unsupported_operation_exception: UnsupportedOperationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .directory_in_use_exception => "DirectoryInUseException",
                .directory_service_authentication_failed_exception => "DirectoryServiceAuthenticationFailedException",
                .directory_unavailable_exception => "DirectoryUnavailableException",
                .email_address_in_use_exception => "EmailAddressInUseException",
                .entity_already_registered_exception => "EntityAlreadyRegisteredException",
                .entity_not_found_exception => "EntityNotFoundException",
                .entity_state_exception => "EntityStateException",
                .invalid_configuration_exception => "InvalidConfigurationException",
                .invalid_custom_ses_configuration_exception => "InvalidCustomSesConfigurationException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_password_exception => "InvalidPasswordException",
                .limit_exceeded_exception => "LimitExceededException",
                .mail_domain_in_use_exception => "MailDomainInUseException",
                .mail_domain_not_found_exception => "MailDomainNotFoundException",
                .mail_domain_state_exception => "MailDomainStateException",
                .name_availability_exception => "NameAvailabilityException",
                .organization_not_found_exception => "OrganizationNotFoundException",
                .organization_state_exception => "OrganizationStateException",
                .reserved_name_exception => "ReservedNameException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .too_many_tags_exception => "TooManyTagsException",
                .unsupported_operation_exception => "UnsupportedOperationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .directory_in_use_exception => |e| e.message,
                .directory_service_authentication_failed_exception => |e| e.message,
                .directory_unavailable_exception => |e| e.message,
                .email_address_in_use_exception => |e| e.message,
                .entity_already_registered_exception => |e| e.message,
                .entity_not_found_exception => |e| e.message,
                .entity_state_exception => |e| e.message,
                .invalid_configuration_exception => |e| e.message,
                .invalid_custom_ses_configuration_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_password_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .mail_domain_in_use_exception => |e| e.message,
                .mail_domain_not_found_exception => |e| e.message,
                .mail_domain_state_exception => |e| e.message,
                .name_availability_exception => |e| e.message,
                .organization_not_found_exception => |e| e.message,
                .organization_state_exception => |e| e.message,
                .reserved_name_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unsupported_operation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .directory_in_use_exception => 400,
                .directory_service_authentication_failed_exception => 400,
                .directory_unavailable_exception => 400,
                .email_address_in_use_exception => 400,
                .entity_already_registered_exception => 400,
                .entity_not_found_exception => 400,
                .entity_state_exception => 400,
                .invalid_configuration_exception => 400,
                .invalid_custom_ses_configuration_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_password_exception => 400,
                .limit_exceeded_exception => 400,
                .mail_domain_in_use_exception => 400,
                .mail_domain_not_found_exception => 400,
                .mail_domain_state_exception => 400,
                .name_availability_exception => 400,
                .organization_not_found_exception => 400,
                .organization_state_exception => 400,
                .reserved_name_exception => 400,
                .resource_not_found_exception => 404,
                .too_many_tags_exception => 400,
                .unsupported_operation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .directory_in_use_exception => |e| e.request_id,
                .directory_service_authentication_failed_exception => |e| e.request_id,
                .directory_unavailable_exception => |e| e.request_id,
                .email_address_in_use_exception => |e| e.request_id,
                .entity_already_registered_exception => |e| e.request_id,
                .entity_not_found_exception => |e| e.request_id,
                .entity_state_exception => |e| e.request_id,
                .invalid_configuration_exception => |e| e.request_id,
                .invalid_custom_ses_configuration_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_password_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .mail_domain_in_use_exception => |e| e.request_id,
                .mail_domain_not_found_exception => |e| e.request_id,
                .mail_domain_state_exception => |e| e.request_id,
                .name_availability_exception => |e| e.request_id,
                .organization_not_found_exception => |e| e.request_id,
                .organization_state_exception => |e| e.request_id,
                .reserved_name_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
                .unsupported_operation_exception => |e| e.request_id,
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

/// The directory is already in use by another WorkMail organization in the same
/// account and Region.
pub const DirectoryInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The directory service doesn't recognize the credentials supplied by
/// WorkMail.
pub const DirectoryServiceAuthenticationFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The directory is unavailable. It might be located in another Region or
/// deleted.
pub const DirectoryUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The email address that you're trying to assign is already created for a
/// different
/// user, group, or resource.
pub const EmailAddressInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The user, group, or resource that you're trying to register is already
/// registered.
pub const EntityAlreadyRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The identifier supplied for the user, group, or resource does not exist in
/// your
/// organization.
pub const EntityNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You are performing an operation on a user, group, or resource that isn't in
/// the
/// expected state, such as trying to delete an active user.
pub const EntityStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The configuration for a resource isn't valid. A resource must either be able
/// to
/// auto-respond to requests or have at least one delegate associated that can
/// do so on its
/// behalf.
pub const InvalidConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You SES configuration has customizations that WorkMail cannot save. The
/// error message lists the invalid setting. For examples of invalid settings,
/// refer to
/// [CreateReceiptRule](https://docs.aws.amazon.com/ses/latest/APIReference/API_CreateReceiptRule.html).
pub const InvalidCustomSesConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// One or more of the input parameters don't match the service's restrictions.
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The supplied password doesn't match the minimum security constraints, such
/// as length
/// or use of special characters.
pub const InvalidPasswordException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request exceeds the limit of the resource.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The domain you're trying to change is in use by another user or organization
/// in your account. See the error message for details.
pub const MailDomainInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The domain specified is not found in your organization.
pub const MailDomainNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// After a domain has been added to the organization, it must be verified. The
/// domain is
/// not yet verified.
pub const MailDomainStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The user, group, or resource name isn't unique in WorkMail.
pub const NameAvailabilityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An operation received a valid organization identifier that either doesn't
/// belong or
/// exist in the system.
pub const OrganizationNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The organization must have a valid state to perform certain
/// operations on the organization or its members.
pub const OrganizationStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This user, group, or resource name is not allowed in WorkMail.
pub const ReservedNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource cannot be found.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource can have up to 50 user-applied tags.
pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You can't perform a write operation against a read-only directory.
pub const UnsupportedOperationException = struct {
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
