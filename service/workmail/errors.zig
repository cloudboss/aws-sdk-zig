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

pub const DirectoryInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DirectoryServiceAuthenticationFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DirectoryUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EmailAddressInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EntityAlreadyRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EntityNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EntityStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCustomSesConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPasswordException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MailDomainInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MailDomainNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MailDomainStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NameAvailabilityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OrganizationNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OrganizationStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReservedNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
