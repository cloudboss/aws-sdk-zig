const aws = @import("aws");

const RegistrationStatus = @import("registration_status.zig").RegistrationStatus;

/// Provides information about the requested registration.
pub const RegistrationInformation = struct {
    /// Metadata about a given registration which is specific to that registration
    /// type.
    additional_attributes: ?[]const aws.map.StringMapEntry,

    /// The version number of the registration that was approved.
    approved_version_number: ?i64,

    /// The time when the registration was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// The current version number of the registration.
    current_version_number: i64,

    /// The latest version number of the registration that was denied.
    latest_denied_version_number: ?i64,

    /// The Amazon Resource Name (ARN) for the registration.
    registration_arn: []const u8,

    /// The unique identifier for the registration.
    registration_id: []const u8,

    /// The status of the registration.
    ///
    /// * `CLOSED`: The phone number or sender ID has been deleted and you must also
    ///   delete the registration for the number.
    /// * `CREATED`: Your registration is created but not submitted.
    /// * `COMPLETE`: Your registration has been approved and your origination
    ///   identity has been created.
    /// * `DELETED`: The registration has been deleted.
    /// * `PROVISIONING`: Your registration has been approved and your origination
    ///   identity is being created.
    /// * `REQUIRES_AUTHENTICATION`: You need to complete email authentication.
    /// * `REQUIRES_UPDATES`: You must fix your registration and resubmit it.
    /// * `REVIEWING`: Your registration has been accepted and is being reviewed.
    /// * `SUBMITTED`: Your registration has been submitted and is awaiting review.
    registration_status: RegistrationStatus,

    /// The type of registration form. The list of **RegistrationTypes** can be
    /// found using the DescribeRegistrationTypeDefinitions action.
    registration_type: []const u8,

    pub const json_field_names = .{
        .additional_attributes = "AdditionalAttributes",
        .approved_version_number = "ApprovedVersionNumber",
        .created_timestamp = "CreatedTimestamp",
        .current_version_number = "CurrentVersionNumber",
        .latest_denied_version_number = "LatestDeniedVersionNumber",
        .registration_arn = "RegistrationArn",
        .registration_id = "RegistrationId",
        .registration_status = "RegistrationStatus",
        .registration_type = "RegistrationType",
    };
};
