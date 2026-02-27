const AwsSecurityFindingIdentifier = @import("aws_security_finding_identifier.zig").AwsSecurityFindingIdentifier;

/// A finding from a `BatchUpdateFindings` request that Security Hub was unable
/// to
/// update.
pub const BatchUpdateFindingsUnprocessedFinding = struct {
    /// The code associated with the error. Possible values are:
    ///
    /// * `ConcurrentUpdateError` - Another request attempted to update the finding
    ///   while this request was being processed.
    /// This error may also occur if you call [
    /// `BatchUpdateFindings`
    /// ](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_BatchUpdateFindings.html)
    /// and [
    /// `BatchImportFindings`
    /// ](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_BatchImportFindings.html) at the same time.
    ///
    /// * `DuplicatedFindingIdentifier` - The request included two or more findings
    ///   with the same `FindingIdentifier`.
    ///
    /// * `FindingNotFound` - The `FindingIdentifier` included in the request did
    ///   not match an existing finding.
    ///
    /// * `FindingSizeExceeded` - The finding size was greater than the permissible
    ///   value of 240 KB.
    ///
    /// * `InternalFailure` - An internal service failure occurred when updating the
    ///   finding.
    ///
    /// * `InvalidInput` - The finding update contained an invalid value that did
    ///   not satisfy the [Amazon Web Services Security Finding
    ///   Format](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-findings-format.html) syntax.
    error_code: []const u8,

    /// The message associated with the error. Possible values are:
    ///
    /// * `Concurrent finding updates detected`
    ///
    /// * `Finding Identifier is duplicated`
    ///
    /// * `Finding Not Found`
    ///
    /// * `Finding size exceeded 240 KB`
    ///
    /// * `Internal service failure`
    ///
    /// * `Invalid Input`
    error_message: []const u8,

    /// The identifier of the finding that was not updated.
    finding_identifier: AwsSecurityFindingIdentifier,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .finding_identifier = "FindingIdentifier",
    };
};
