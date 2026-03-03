const AwsSecurityFindingIdentifier = @import("aws_security_finding_identifier.zig").AwsSecurityFindingIdentifier;
const FindingHistoryUpdate = @import("finding_history_update.zig").FindingHistoryUpdate;
const FindingHistoryUpdateSource = @import("finding_history_update_source.zig").FindingHistoryUpdateSource;

/// A list of events that changed the specified finding during the specified
/// time period. Each record represents a single
/// finding change event.
pub const FindingHistoryRecord = struct {
    /// Identifies whether the event marks the creation of a new finding. A value of
    /// `True` means that the finding is
    /// newly created. A value of `False` means that the finding isn’t newly
    /// created.
    finding_created: ?bool = null,

    finding_identifier: ?AwsSecurityFindingIdentifier = null,

    /// A token for pagination purposes. Provide this token in the subsequent
    /// request to [
    /// `GetFindingsHistory`
    /// ](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_GetFindingsHistory.html) to get
    /// up to an additional 100 results of history for the same finding that you
    /// specified in your initial request.
    next_token: ?[]const u8 = null,

    /// An array of objects that provides details about the finding change event,
    /// including the Amazon Web Services Security
    /// Finding Format (ASFF) field that changed, the value of the field before the
    /// change, and the value of the field after
    /// the change.
    updates: ?[]const FindingHistoryUpdate = null,

    /// Identifies the source of the event that changed the finding. For example, an
    /// integrated
    /// Amazon Web Services service or third-party partner integration may call [
    /// `BatchImportFindings`
    /// ](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_BatchImportFindings.html), or an Security Hub customer
    /// may call [
    /// `BatchUpdateFindings`
    /// ](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_BatchUpdateFindings.html).
    update_source: ?FindingHistoryUpdateSource = null,

    /// A timestamp that indicates when Security Hub
    /// processed the updated finding record.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    update_time: ?i64 = null,

    pub const json_field_names = .{
        .finding_created = "FindingCreated",
        .finding_identifier = "FindingIdentifier",
        .next_token = "NextToken",
        .updates = "Updates",
        .update_source = "UpdateSource",
        .update_time = "UpdateTime",
    };
};
