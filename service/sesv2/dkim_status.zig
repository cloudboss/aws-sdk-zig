/// The DKIM authentication status of the identity. The status can be one of the
/// following:
///
/// * `PENDING` – The verification process was initiated, but Amazon SES
/// hasn't yet detected the DKIM records in the DNS configuration for the
/// domain.
///
/// * `SUCCESS` – The verification process completed
/// successfully.
///
/// * `FAILED` – The verification process failed. This typically
/// occurs when Amazon SES fails to find the DKIM records in the DNS
/// configuration of the
/// domain.
///
/// * `TEMPORARY_FAILURE` – A temporary issue is preventing Amazon SES
/// from determining the DKIM authentication status of the domain.
///
/// * `NOT_STARTED` – The DKIM verification process hasn't been
/// initiated for the domain.
pub const DkimStatus = enum {
    pending,
    success,
    failed,
    temporary_failure,
    not_started,

    pub const json_field_names = .{
        .pending = "PENDING",
        .success = "SUCCESS",
        .failed = "FAILED",
        .temporary_failure = "TEMPORARY_FAILURE",
        .not_started = "NOT_STARTED",
    };
};
