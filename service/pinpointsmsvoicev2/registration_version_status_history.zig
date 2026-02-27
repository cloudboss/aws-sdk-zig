/// The **RegistrationVersionStatusHistory** object contains the time stamps for
/// when the reservations status changes.
pub const RegistrationVersionStatusHistory = struct {
    /// The time when the registration was in the approved state, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    approved_timestamp: ?i64,

    /// The time when the registration was in the archived state, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    archived_timestamp: ?i64,

    /// The time when the registration was in the AWS reviewing state, in [UNIX
    /// epoch time](https://www.epochconverter.com/) format.
    aws_reviewing_timestamp: ?i64,

    /// The time when the registration was in the denied state, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    denied_timestamp: ?i64,

    /// The time when the registration was in the discarded state, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    discarded_timestamp: ?i64,

    /// The time when the registration was in the draft state, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    draft_timestamp: i64,

    /// The time when the registration was in the requires authentication state, in
    /// [UNIX epoch time](https://www.epochconverter.com/) format.
    requires_authentication_timestamp: ?i64,

    /// The time when the registration was in the reviewing state, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    reviewing_timestamp: ?i64,

    /// The time when the registration was in the revoked state, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    revoked_timestamp: ?i64,

    /// The time when the registration was in the submitted state, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    submitted_timestamp: ?i64,

    pub const json_field_names = .{
        .approved_timestamp = "ApprovedTimestamp",
        .archived_timestamp = "ArchivedTimestamp",
        .aws_reviewing_timestamp = "AwsReviewingTimestamp",
        .denied_timestamp = "DeniedTimestamp",
        .discarded_timestamp = "DiscardedTimestamp",
        .draft_timestamp = "DraftTimestamp",
        .requires_authentication_timestamp = "RequiresAuthenticationTimestamp",
        .reviewing_timestamp = "ReviewingTimestamp",
        .revoked_timestamp = "RevokedTimestamp",
        .submitted_timestamp = "SubmittedTimestamp",
    };
};
