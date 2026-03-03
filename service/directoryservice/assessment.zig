/// Contains detailed information about a directory assessment, including
/// configuration
/// parameters, status, and validation results.
pub const Assessment = struct {
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

    /// The type of assessment report generated. Valid values are `CUSTOMER` and
    /// `SYSTEM`.
    report_type: ?[]const u8 = null,

    /// The security groups identifiers attached to the network interfaces.
    security_group_ids: ?[]const []const u8 = null,

    /// The identifiers of the self-managed AD instances used to perform the
    /// assessment.
    self_managed_instance_ids: ?[]const []const u8 = null,

    /// The date and time when the assessment was initiated.
    start_time: ?i64 = null,

    /// The current status of the assessment. Valid values include `SUCCESS`,
    /// `FAILED`, `PENDING`, and `IN_PROGRESS`.
    status: ?[]const u8 = null,

    /// A detailed status code providing additional information about the assessment
    /// state.
    status_code: ?[]const u8 = null,

    /// A human-readable description of the current assessment status, including any
    /// error
    /// details or progress information.
    status_reason: ?[]const u8 = null,

    /// A list of subnet identifiers in the Amazon VPC in which the hybrid directory
    /// is
    /// created.
    subnet_ids: ?[]const []const u8 = null,

    /// The version of the assessment framework used to evaluate your self-managed
    /// AD
    /// environment.
    version: ?[]const u8 = null,

    /// Contains Amazon VPC information for the `StartADAssessment` operation.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_id = "AssessmentId",
        .customer_dns_ips = "CustomerDnsIps",
        .directory_id = "DirectoryId",
        .dns_name = "DnsName",
        .last_update_date_time = "LastUpdateDateTime",
        .report_type = "ReportType",
        .security_group_ids = "SecurityGroupIds",
        .self_managed_instance_ids = "SelfManagedInstanceIds",
        .start_time = "StartTime",
        .status = "Status",
        .status_code = "StatusCode",
        .status_reason = "StatusReason",
        .subnet_ids = "SubnetIds",
        .version = "Version",
        .vpc_id = "VpcId",
    };
};
