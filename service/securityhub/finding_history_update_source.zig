const FindingHistoryUpdateSourceType = @import("finding_history_update_source_type.zig").FindingHistoryUpdateSourceType;

/// Identifies the source of the finding change event.
pub const FindingHistoryUpdateSource = struct {
    /// The identity of the source that initiated the finding change event. For
    /// example, the Amazon Resource Name (ARN) of a partner that calls
    /// BatchImportFindings or of a customer that calls BatchUpdateFindings.
    identity: ?[]const u8,

    /// Describes the type of finding change event, such as a call to [
    /// `BatchImportFindings`
    /// ](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_BatchImportFindings.html) (by an integrated Amazon Web Services service or third party partner integration) or [
    /// `BatchUpdateFindings`
    /// ](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_BatchUpdateFindings.html) (by a Security Hub customer).
    @"type": ?FindingHistoryUpdateSourceType,

    pub const json_field_names = .{
        .identity = "Identity",
        .@"type" = "Type",
    };
};
