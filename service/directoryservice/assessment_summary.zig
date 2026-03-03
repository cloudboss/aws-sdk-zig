/// Contains summary information about a directory assessment, providing a
/// high-level
/// overview without detailed validation results.
pub const AssessmentSummary = struct {
    /// The unique identifier of the directory assessment.
    assessment_id: ?[]const u8 = null,

    /// The IP addresses of the DNS servers or domain controllers in your
    /// self-managed AD
    /// environment.
    customer_dns_ips: ?[]const []const u8 = null,

    /// The identifier of the directory associated with this assessment.
    directory_id: ?[]const u8 = null,

    /// The fully qualified domain name (FQDN) of the Active Directory domain being
    /// assessed.
    dns_name: ?[]const u8 = null,

    /// The date and time when the assessment status was last updated.
    last_update_date_time: ?i64 = null,

    /// The type of assessment report generated. Valid values include `CUSTOMER`
    /// and `SYSTEM`.
    report_type: ?[]const u8 = null,

    /// The date and time when the assessment was initiated.
    start_time: ?i64 = null,

    /// The current status of the assessment. Valid values include `SUCCESS`,
    /// `FAILED`, `PENDING`, and `IN_PROGRESS`.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_id = "AssessmentId",
        .customer_dns_ips = "CustomerDnsIps",
        .directory_id = "DirectoryId",
        .dns_name = "DnsName",
        .last_update_date_time = "LastUpdateDateTime",
        .report_type = "ReportType",
        .start_time = "StartTime",
        .status = "Status",
    };
};
