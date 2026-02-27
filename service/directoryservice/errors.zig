const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        ad_assessment_limit_exceeded_exception: ADAssessmentLimitExceededException,
        authentication_failed_exception: AuthenticationFailedException,
        certificate_already_exists_exception: CertificateAlreadyExistsException,
        certificate_does_not_exist_exception: CertificateDoesNotExistException,
        certificate_in_use_exception: CertificateInUseException,
        certificate_limit_exceeded_exception: CertificateLimitExceededException,
        client_exception: ClientException,
        directory_already_in_region_exception: DirectoryAlreadyInRegionException,
        directory_already_shared_exception: DirectoryAlreadySharedException,
        directory_does_not_exist_exception: DirectoryDoesNotExistException,
        directory_in_desired_state_exception: DirectoryInDesiredStateException,
        directory_limit_exceeded_exception: DirectoryLimitExceededException,
        directory_not_shared_exception: DirectoryNotSharedException,
        directory_unavailable_exception: DirectoryUnavailableException,
        disable_already_in_progress_exception: DisableAlreadyInProgressException,
        domain_controller_limit_exceeded_exception: DomainControllerLimitExceededException,
        enable_already_in_progress_exception: EnableAlreadyInProgressException,
        entity_already_exists_exception: EntityAlreadyExistsException,
        entity_does_not_exist_exception: EntityDoesNotExistException,
        incompatible_settings_exception: IncompatibleSettingsException,
        insufficient_permissions_exception: InsufficientPermissionsException,
        invalid_certificate_exception: InvalidCertificateException,
        invalid_client_auth_status_exception: InvalidClientAuthStatusException,
        invalid_ldaps_status_exception: InvalidLDAPSStatusException,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_password_exception: InvalidPasswordException,
        invalid_target_exception: InvalidTargetException,
        ip_route_limit_exceeded_exception: IpRouteLimitExceededException,
        no_available_certificate_exception: NoAvailableCertificateException,
        organizations_exception: OrganizationsException,
        region_limit_exceeded_exception: RegionLimitExceededException,
        service_exception: ServiceException,
        share_limit_exceeded_exception: ShareLimitExceededException,
        snapshot_limit_exceeded_exception: SnapshotLimitExceededException,
        tag_limit_exceeded_exception: TagLimitExceededException,
        unsupported_operation_exception: UnsupportedOperationException,
        unsupported_settings_exception: UnsupportedSettingsException,
        user_does_not_exist_exception: UserDoesNotExistException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .ad_assessment_limit_exceeded_exception => "ADAssessmentLimitExceededException",
                .authentication_failed_exception => "AuthenticationFailedException",
                .certificate_already_exists_exception => "CertificateAlreadyExistsException",
                .certificate_does_not_exist_exception => "CertificateDoesNotExistException",
                .certificate_in_use_exception => "CertificateInUseException",
                .certificate_limit_exceeded_exception => "CertificateLimitExceededException",
                .client_exception => "ClientException",
                .directory_already_in_region_exception => "DirectoryAlreadyInRegionException",
                .directory_already_shared_exception => "DirectoryAlreadySharedException",
                .directory_does_not_exist_exception => "DirectoryDoesNotExistException",
                .directory_in_desired_state_exception => "DirectoryInDesiredStateException",
                .directory_limit_exceeded_exception => "DirectoryLimitExceededException",
                .directory_not_shared_exception => "DirectoryNotSharedException",
                .directory_unavailable_exception => "DirectoryUnavailableException",
                .disable_already_in_progress_exception => "DisableAlreadyInProgressException",
                .domain_controller_limit_exceeded_exception => "DomainControllerLimitExceededException",
                .enable_already_in_progress_exception => "EnableAlreadyInProgressException",
                .entity_already_exists_exception => "EntityAlreadyExistsException",
                .entity_does_not_exist_exception => "EntityDoesNotExistException",
                .incompatible_settings_exception => "IncompatibleSettingsException",
                .insufficient_permissions_exception => "InsufficientPermissionsException",
                .invalid_certificate_exception => "InvalidCertificateException",
                .invalid_client_auth_status_exception => "InvalidClientAuthStatusException",
                .invalid_ldaps_status_exception => "InvalidLDAPSStatusException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_password_exception => "InvalidPasswordException",
                .invalid_target_exception => "InvalidTargetException",
                .ip_route_limit_exceeded_exception => "IpRouteLimitExceededException",
                .no_available_certificate_exception => "NoAvailableCertificateException",
                .organizations_exception => "OrganizationsException",
                .region_limit_exceeded_exception => "RegionLimitExceededException",
                .service_exception => "ServiceException",
                .share_limit_exceeded_exception => "ShareLimitExceededException",
                .snapshot_limit_exceeded_exception => "SnapshotLimitExceededException",
                .tag_limit_exceeded_exception => "TagLimitExceededException",
                .unsupported_operation_exception => "UnsupportedOperationException",
                .unsupported_settings_exception => "UnsupportedSettingsException",
                .user_does_not_exist_exception => "UserDoesNotExistException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .ad_assessment_limit_exceeded_exception => |e| e.message,
                .authentication_failed_exception => |e| e.message,
                .certificate_already_exists_exception => |e| e.message,
                .certificate_does_not_exist_exception => |e| e.message,
                .certificate_in_use_exception => |e| e.message,
                .certificate_limit_exceeded_exception => |e| e.message,
                .client_exception => |e| e.message,
                .directory_already_in_region_exception => |e| e.message,
                .directory_already_shared_exception => |e| e.message,
                .directory_does_not_exist_exception => |e| e.message,
                .directory_in_desired_state_exception => |e| e.message,
                .directory_limit_exceeded_exception => |e| e.message,
                .directory_not_shared_exception => |e| e.message,
                .directory_unavailable_exception => |e| e.message,
                .disable_already_in_progress_exception => |e| e.message,
                .domain_controller_limit_exceeded_exception => |e| e.message,
                .enable_already_in_progress_exception => |e| e.message,
                .entity_already_exists_exception => |e| e.message,
                .entity_does_not_exist_exception => |e| e.message,
                .incompatible_settings_exception => |e| e.message,
                .insufficient_permissions_exception => |e| e.message,
                .invalid_certificate_exception => |e| e.message,
                .invalid_client_auth_status_exception => |e| e.message,
                .invalid_ldaps_status_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_password_exception => |e| e.message,
                .invalid_target_exception => |e| e.message,
                .ip_route_limit_exceeded_exception => |e| e.message,
                .no_available_certificate_exception => |e| e.message,
                .organizations_exception => |e| e.message,
                .region_limit_exceeded_exception => |e| e.message,
                .service_exception => |e| e.message,
                .share_limit_exceeded_exception => |e| e.message,
                .snapshot_limit_exceeded_exception => |e| e.message,
                .tag_limit_exceeded_exception => |e| e.message,
                .unsupported_operation_exception => |e| e.message,
                .unsupported_settings_exception => |e| e.message,
                .user_does_not_exist_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 400,
                .ad_assessment_limit_exceeded_exception => 400,
                .authentication_failed_exception => 400,
                .certificate_already_exists_exception => 400,
                .certificate_does_not_exist_exception => 400,
                .certificate_in_use_exception => 400,
                .certificate_limit_exceeded_exception => 400,
                .client_exception => 400,
                .directory_already_in_region_exception => 400,
                .directory_already_shared_exception => 400,
                .directory_does_not_exist_exception => 400,
                .directory_in_desired_state_exception => 400,
                .directory_limit_exceeded_exception => 400,
                .directory_not_shared_exception => 400,
                .directory_unavailable_exception => 400,
                .disable_already_in_progress_exception => 400,
                .domain_controller_limit_exceeded_exception => 400,
                .enable_already_in_progress_exception => 400,
                .entity_already_exists_exception => 400,
                .entity_does_not_exist_exception => 400,
                .incompatible_settings_exception => 400,
                .insufficient_permissions_exception => 400,
                .invalid_certificate_exception => 400,
                .invalid_client_auth_status_exception => 400,
                .invalid_ldaps_status_exception => 400,
                .invalid_next_token_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_password_exception => 400,
                .invalid_target_exception => 400,
                .ip_route_limit_exceeded_exception => 400,
                .no_available_certificate_exception => 400,
                .organizations_exception => 400,
                .region_limit_exceeded_exception => 400,
                .service_exception => 500,
                .share_limit_exceeded_exception => 400,
                .snapshot_limit_exceeded_exception => 400,
                .tag_limit_exceeded_exception => 400,
                .unsupported_operation_exception => 400,
                .unsupported_settings_exception => 400,
                .user_does_not_exist_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .ad_assessment_limit_exceeded_exception => |e| e.request_id,
                .authentication_failed_exception => |e| e.request_id,
                .certificate_already_exists_exception => |e| e.request_id,
                .certificate_does_not_exist_exception => |e| e.request_id,
                .certificate_in_use_exception => |e| e.request_id,
                .certificate_limit_exceeded_exception => |e| e.request_id,
                .client_exception => |e| e.request_id,
                .directory_already_in_region_exception => |e| e.request_id,
                .directory_already_shared_exception => |e| e.request_id,
                .directory_does_not_exist_exception => |e| e.request_id,
                .directory_in_desired_state_exception => |e| e.request_id,
                .directory_limit_exceeded_exception => |e| e.request_id,
                .directory_not_shared_exception => |e| e.request_id,
                .directory_unavailable_exception => |e| e.request_id,
                .disable_already_in_progress_exception => |e| e.request_id,
                .domain_controller_limit_exceeded_exception => |e| e.request_id,
                .enable_already_in_progress_exception => |e| e.request_id,
                .entity_already_exists_exception => |e| e.request_id,
                .entity_does_not_exist_exception => |e| e.request_id,
                .incompatible_settings_exception => |e| e.request_id,
                .insufficient_permissions_exception => |e| e.request_id,
                .invalid_certificate_exception => |e| e.request_id,
                .invalid_client_auth_status_exception => |e| e.request_id,
                .invalid_ldaps_status_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_password_exception => |e| e.request_id,
                .invalid_target_exception => |e| e.request_id,
                .ip_route_limit_exceeded_exception => |e| e.request_id,
                .no_available_certificate_exception => |e| e.request_id,
                .organizations_exception => |e| e.request_id,
                .region_limit_exceeded_exception => |e| e.request_id,
                .service_exception => |e| e.request_id,
                .share_limit_exceeded_exception => |e| e.request_id,
                .snapshot_limit_exceeded_exception => |e| e.request_id,
                .tag_limit_exceeded_exception => |e| e.request_id,
                .unsupported_operation_exception => |e| e.request_id,
                .unsupported_settings_exception => |e| e.request_id,
                .user_does_not_exist_exception => |e| e.request_id,
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

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ADAssessmentLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AuthenticationFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CertificateAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CertificateDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CertificateInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CertificateLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClientException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DirectoryAlreadyInRegionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DirectoryAlreadySharedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DirectoryDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DirectoryInDesiredStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DirectoryLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DirectoryNotSharedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DirectoryUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DisableAlreadyInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DomainControllerLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EnableAlreadyInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EntityAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EntityDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IncompatibleSettingsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientPermissionsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCertificateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidClientAuthStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidLDAPSStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNextTokenException = struct {
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

pub const InvalidTargetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IpRouteLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoAvailableCertificateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OrganizationsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RegionLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ShareLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedSettingsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UserDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
