const AssociatedStandard = @import("associated_standard.zig").AssociatedStandard;
const SecurityControlParameter = @import("security_control_parameter.zig").SecurityControlParameter;
const ComplianceStatus = @import("compliance_status.zig").ComplianceStatus;
const StatusReason = @import("status_reason.zig").StatusReason;

/// This object typically provides details about a control finding, such as
/// applicable standards and the status of
/// control checks. While finding providers can add custom content in
/// `Compliance` object fields, they are
/// typically used to review details of Security Hub control findings.
pub const Compliance = struct {
    /// Typically provides an array of enabled security standards in which a
    /// security control is currently enabled.
    associated_standards: ?[]const AssociatedStandard,

    /// Typically provides the industry or regulatory framework requirements that
    /// are related to a
    /// control. The check for that control is aligned with these requirements.
    ///
    /// Array Members: Maximum number of 32 items.
    related_requirements: ?[]const []const u8,

    /// Typically provides the unique identifier of a control across standards. For
    /// Security Hub controls, this field consists of an
    /// Amazon Web Services service and a unique number, such as `APIGateway.5`.
    security_control_id: ?[]const u8,

    /// Typically an object that includes security control parameter names and
    /// values.
    security_control_parameters: ?[]const SecurityControlParameter,

    /// Typically summarizes the result of a control check.
    ///
    /// For Security Hub controls, valid values for `Status` are as follows.
    ///
    /// *
    ///
    /// * `PASSED` - Standards check passed for all evaluated
    /// resources.
    ///
    /// * `WARNING` - Some information is missing or this check is not
    /// supported for your configuration.
    ///
    /// * `FAILED` - Standards check failed for at least one evaluated
    /// resource.
    ///
    /// * `NOT_AVAILABLE` - Check could not be performed due to a service
    /// outage, API error, or because the result of the Config evaluation was
    /// `NOT_APPLICABLE`. If the Config evaluation result was
    /// `NOT_APPLICABLE` for a Security Hub control, Security Hub automatically
    /// archives
    /// the finding after 3 days.
    status: ?ComplianceStatus,

    /// Typically used to provide a list of reasons for the value of `Status`.
    status_reasons: ?[]const StatusReason,

    pub const json_field_names = .{
        .associated_standards = "AssociatedStandards",
        .related_requirements = "RelatedRequirements",
        .security_control_id = "SecurityControlId",
        .security_control_parameters = "SecurityControlParameters",
        .status = "Status",
        .status_reasons = "StatusReasons",
    };
};
