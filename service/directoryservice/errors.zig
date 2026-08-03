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

/// You do not have sufficient access to perform this action.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// A directory assessment is automatically created when you create a hybrid
/// directory.
/// There are two types of assessments: `CUSTOMER` and `SYSTEM`. Your
/// Amazon Web Services account has a limit of 100 `CUSTOMER` directory
/// assessments.
///
/// If you attempt to create a hybrid directory; and you already have 100
/// `CUSTOMER` directory assessments;, you will encounter an error. Delete
/// assessments to free up capacity before trying again.
///
/// You can request an increase to your `CUSTOMER` directory assessment quota
/// by contacting customer support or delete existing CUSTOMER directory
/// assessments; to
/// free up capacity.
pub const ADAssessmentLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// An authentication error occurred.
pub const AuthenticationFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The certificate has already been registered into the system.
pub const CertificateAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The certificate is not present in the system for describe or deregister
/// activities.
pub const CertificateDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The certificate is being used for the LDAP security connection and cannot be
/// removed
/// without disabling LDAP security.
pub const CertificateInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The certificate could not be added because the certificate limit has been
/// reached.
pub const CertificateLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// A client exception has occurred.
pub const ClientException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The Region you specified is the same Region where the Managed Microsoft AD
/// directory was created.
/// Specify a different Region and try again.
pub const DirectoryAlreadyInRegionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The specified directory has already been shared with this Amazon Web
/// Services account.
pub const DirectoryAlreadySharedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The specified directory does not exist in the system.
pub const DirectoryDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The directory is already updated to desired update type settings.
pub const DirectoryInDesiredStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The maximum number of directories in the region has been reached. You can
/// use the
/// GetDirectoryLimits operation to determine your directory limits in
/// the region.
pub const DirectoryLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The specified directory has not been shared with this Amazon Web Services
/// account.
pub const DirectoryNotSharedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The specified directory is unavailable.
pub const DirectoryUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// A disable operation for CA enrollment policy is already in progress for this
/// directory.
pub const DisableAlreadyInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The maximum allowed number of domain controllers per directory was exceeded.
/// The
/// default limit per directory is 20 domain controllers.
pub const DomainControllerLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// An enable operation for CA enrollment policy is already in progress for this
/// directory.
pub const EnableAlreadyInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The specified entity already exists.
pub const EntityAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The specified entity could not be found.
pub const EntityDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The specified directory setting is not compatible with other settings.
pub const IncompatibleSettingsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The account does not have sufficient permission to perform the operation.
pub const InsufficientPermissionsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The certificate PEM that was provided has incorrect encoding.
pub const InvalidCertificateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// Client authentication is already enabled.
pub const InvalidClientAuthStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The LDAP activities could not be performed because they are limited by the
/// LDAPS
/// status.
pub const InvalidLDAPSStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The `NextToken` value is not valid.
pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// One or more parameters are not valid.
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The new password provided by the user does not meet the password complexity
/// requirements defined in your directory.
pub const InvalidPasswordException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The specified shared target is not valid.
pub const InvalidTargetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The maximum allowed number of IP addresses was exceeded. The default limit
/// is 100 IP
/// address blocks.
pub const IpRouteLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// Client authentication setup could not be completed because at least one
/// valid certificate
/// must be registered in the system.
pub const NoAvailableCertificateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// Exception encountered while trying to access your Amazon Web Services
/// organization.
pub const OrganizationsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// You have reached the limit for maximum number of simultaneous Region
/// replications per
/// directory.
pub const RegionLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// An exception has occurred in Directory Service.
pub const ServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The maximum number of Amazon Web Services accounts that you can share with
/// this directory has been
/// reached.
pub const ShareLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The maximum number of manual snapshots for the directory has been reached.
/// You can
/// use the GetSnapshotLimits operation to determine the snapshot limits
/// for a directory.
pub const SnapshotLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The maximum allowed number of tags was exceeded.
pub const TagLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The operation is not supported.
pub const UnsupportedOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The specified directory setting is not supported.
pub const UnsupportedSettingsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

/// The user provided a username that does not exist in your directory.
pub const UserDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestId",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
