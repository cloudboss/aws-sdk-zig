const ReportDeliveryChannel = @import("report_delivery_channel.zig").ReportDeliveryChannel;
const ReportSetting = @import("report_setting.zig").ReportSetting;

/// Contains detailed information about a report plan.
pub const ReportPlan = struct {
    /// The date and time that a report plan is created, in Unix format and
    /// Coordinated
    /// Universal Time (UTC). The value of `CreationTime` is accurate to
    /// milliseconds.
    /// For example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    creation_time: ?i64 = null,

    /// The deployment status of a report plan. The statuses are:
    ///
    /// `CREATE_IN_PROGRESS | UPDATE_IN_PROGRESS | DELETE_IN_PROGRESS |
    /// COMPLETED`
    deployment_status: ?[]const u8 = null,

    /// The date and time that a report job associated with this report plan last
    /// attempted to
    /// run, in Unix format and Coordinated Universal Time (UTC). The value of
    /// `LastAttemptedExecutionTime` is accurate to milliseconds. For example, the
    /// value 1516925490.087 represents Friday, January 26, 2018 12:11:30.087 AM.
    last_attempted_execution_time: ?i64 = null,

    /// The date and time that a report job associated with this report plan last
    /// successfully
    /// ran, in Unix format and Coordinated Universal Time (UTC). The value of
    /// `LastSuccessfulExecutionTime` is accurate to milliseconds. For example, the
    /// value 1516925490.087 represents Friday, January 26, 2018 12:11:30.087 AM.
    last_successful_execution_time: ?i64 = null,

    /// Contains information about where and how to deliver your reports,
    /// specifically your
    /// Amazon S3 bucket name, S3 key prefix, and the formats of your reports.
    report_delivery_channel: ?ReportDeliveryChannel = null,

    /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
    /// format of the ARN
    /// depends on the resource type.
    report_plan_arn: ?[]const u8 = null,

    /// An optional description of the report plan with a maximum 1,024 characters.
    report_plan_description: ?[]const u8 = null,

    /// The unique name of the report plan. This name is between 1 and 256
    /// characters starting
    /// with a letter, and consisting of letters (a-z, A-Z), numbers (0-9), and
    /// underscores
    /// (_).
    report_plan_name: ?[]const u8 = null,

    /// Identifies the report template for the report. Reports are built using a
    /// report
    /// template. The report templates are:
    ///
    /// `RESOURCE_COMPLIANCE_REPORT | CONTROL_COMPLIANCE_REPORT | BACKUP_JOB_REPORT
    /// |
    /// COPY_JOB_REPORT | RESTORE_JOB_REPORT`
    ///
    /// If the report template is `RESOURCE_COMPLIANCE_REPORT` or
    /// `CONTROL_COMPLIANCE_REPORT`, this API resource also describes the report
    /// coverage by Amazon Web Services Regions and frameworks.
    report_setting: ?ReportSetting = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .deployment_status = "DeploymentStatus",
        .last_attempted_execution_time = "LastAttemptedExecutionTime",
        .last_successful_execution_time = "LastSuccessfulExecutionTime",
        .report_delivery_channel = "ReportDeliveryChannel",
        .report_plan_arn = "ReportPlanArn",
        .report_plan_description = "ReportPlanDescription",
        .report_plan_name = "ReportPlanName",
        .report_setting = "ReportSetting",
    };
};
