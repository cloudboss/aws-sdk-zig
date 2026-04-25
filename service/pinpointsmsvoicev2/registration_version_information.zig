const RegistrationDeniedReasonInformation = @import("registration_denied_reason_information.zig").RegistrationDeniedReasonInformation;
const RegistrationVersionStatus = @import("registration_version_status.zig").RegistrationVersionStatus;
const RegistrationVersionStatusHistory = @import("registration_version_status_history.zig").RegistrationVersionStatusHistory;

/// Provides information about the specified version of the registration.
pub const RegistrationVersionInformation = struct {
    /// An array of RegistrationDeniedReasonInformation objects.
    denied_reasons: ?[]const RegistrationDeniedReasonInformation = null,

    /// Generative AI feedback information provided during the registration review
    /// process. This includes comments, suggestions, or additional requirements.
    feedback: ?[]const u8 = null,

    /// The status of the registration.
    ///
    /// * `APPROVED`: Your registration has been approved.
    /// * `ARCHIVED`: Your previously approved registration version moves into this
    ///   status when a more recently submitted version is approved.
    /// * `DENIED`: You must fix your registration and resubmit it.
    /// * `DISCARDED`: You've abandon this version of their registration to start
    ///   over with a new version.
    /// * `DRAFT`: The initial status of a registration version after it’s created.
    /// * `REQUIRES_AUTHENTICATION`: You need to complete email authentication.
    /// * `REVIEWING`: Your registration has been accepted and is being reviewed.
    /// * `REVOKED`: Your previously approved registration has been revoked.
    /// * `SUBMITTED`: Your registration has been submitted.
    registration_version_status: RegistrationVersionStatus,

    /// The **RegistrationVersionStatusHistory** object contains the time stamps for
    /// when the reservations status changes.
    registration_version_status_history: RegistrationVersionStatusHistory,

    /// The version number of the registration.
    version_number: i64,

    pub const json_field_names = .{
        .denied_reasons = "DeniedReasons",
        .feedback = "Feedback",
        .registration_version_status = "RegistrationVersionStatus",
        .registration_version_status_history = "RegistrationVersionStatusHistory",
        .version_number = "VersionNumber",
    };
};
