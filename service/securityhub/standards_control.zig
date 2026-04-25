const ControlStatus = @import("control_status.zig").ControlStatus;
const SeverityRating = @import("severity_rating.zig").SeverityRating;

/// Details for an individual security standard control.
pub const StandardsControl = struct {
    /// The identifier of the security standard control.
    control_id: ?[]const u8 = null,

    /// The current status of the security standard control. Indicates whether the
    /// control is
    /// enabled or disabled. Security Hub CSPM does not check against disabled
    /// controls.
    control_status: ?ControlStatus = null,

    /// The date and time that the status of the security standard control was most
    /// recently
    /// updated.
    control_status_updated_at: ?i64 = null,

    /// The longer description of the security standard control. Provides
    /// information about what
    /// the control is checking for.
    description: ?[]const u8 = null,

    /// The reason provided for the most recent change in status for the control.
    disabled_reason: ?[]const u8 = null,

    /// The list of requirements that are related to this control.
    related_requirements: ?[]const []const u8 = null,

    /// A link to remediation information for the control in the Security Hub CSPM
    /// user
    /// documentation.
    remediation_url: ?[]const u8 = null,

    /// The severity of findings generated from this security standard control.
    ///
    /// The finding severity is based on an assessment of how easy it would be to
    /// compromise Amazon Web Services
    /// resources if the issue is detected.
    severity_rating: ?SeverityRating = null,

    /// The ARN of the security standard control.
    standards_control_arn: ?[]const u8 = null,

    /// The title of the security standard control.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .control_id = "ControlId",
        .control_status = "ControlStatus",
        .control_status_updated_at = "ControlStatusUpdatedAt",
        .description = "Description",
        .disabled_reason = "DisabledReason",
        .related_requirements = "RelatedRequirements",
        .remediation_url = "RemediationUrl",
        .severity_rating = "SeverityRating",
        .standards_control_arn = "StandardsControlArn",
        .title = "Title",
    };
};
