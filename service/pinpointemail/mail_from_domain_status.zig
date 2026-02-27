/// The status of the MAIL FROM domain. This status can have the following
/// values:
///
/// * `PENDING` – Amazon Pinpoint hasn't started searching for the MX record
/// yet.
///
/// * `SUCCESS` – Amazon Pinpoint detected the required MX record for the
/// MAIL FROM domain.
///
/// * `FAILED` – Amazon Pinpoint can't find the required MX record, or the
/// record no longer exists.
///
/// * `TEMPORARY_FAILURE` – A temporary issue occurred, which
/// prevented Amazon Pinpoint from determining the status of the MAIL FROM
/// domain.
pub const MailFromDomainStatus = enum {
    pending,
    success,
    failed,
    temporary_failure,

    pub const json_field_names = .{
        .pending = "PENDING",
        .success = "SUCCESS",
        .failed = "FAILED",
        .temporary_failure = "TEMPORARY_FAILURE",
    };
};
