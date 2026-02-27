const aws = @import("aws");

/// Contains information about the findings for an Amazon Web Services account
/// in an organization unused access analyzer.
pub const FindingAggregationAccountDetails = struct {
    /// The ID of the Amazon Web Services account for which unused access finding
    /// details are provided.
    account: ?[]const u8,

    /// Provides the number of active findings for each type of unused access for
    /// the specified Amazon Web Services account.
    details: ?[]const aws.map.MapEntry(i32),

    /// The number of active unused access findings for the specified Amazon Web
    /// Services account.
    number_of_active_findings: ?i32,

    pub const json_field_names = .{
        .account = "account",
        .details = "details",
        .number_of_active_findings = "numberOfActiveFindings",
    };
};
