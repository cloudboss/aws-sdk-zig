const AssociationStatus = @import("association_status.zig").AssociationStatus;

/// Provides details about a control's enablement status in a specified
/// standard.
pub const StandardsControlAssociationDetail = struct {
    /// Specifies whether a control is enabled or disabled in a specified standard.
    association_status: AssociationStatus,

    /// The requirement that underlies a control in the compliance framework related
    /// to the standard.
    related_requirements: ?[]const []const u8 = null,

    /// The ARN of a security control across standards, such as
    /// `arn:aws:securityhub:eu-central-1:123456789012:security-control/S3.1`. This
    /// parameter doesn't mention a specific standard.
    security_control_arn: []const u8,

    /// The unique identifier of a security control across standards. Values for
    /// this field typically consist of an Amazon Web Services service
    /// name and a number, such as APIGateway.3.
    security_control_id: []const u8,

    /// The Amazon Resource Name (ARN) of a security standard.
    standards_arn: []const u8,

    /// Provides the input parameter that Security Hub uses to call the
    /// [UpdateStandardsControl](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_UpdateStandardsControl.html) API. This API can be used to enable or disable a control
    /// in a specified standard.
    standards_control_arns: ?[]const []const u8 = null,

    /// The description of a control. This typically summarizes how Security Hub
    /// evaluates the control and the
    /// conditions under which it produces a failed finding. This parameter may
    /// reference a specific standard.
    standards_control_description: ?[]const u8 = null,

    /// The title of a control. This field may reference a specific standard.
    standards_control_title: ?[]const u8 = null,

    /// The time at which the enablement status of the control in the specified
    /// standard was last updated.
    updated_at: ?i64 = null,

    /// The reason for updating the enablement status of a control in a specified
    /// standard.
    updated_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_status = "AssociationStatus",
        .related_requirements = "RelatedRequirements",
        .security_control_arn = "SecurityControlArn",
        .security_control_id = "SecurityControlId",
        .standards_arn = "StandardsArn",
        .standards_control_arns = "StandardsControlArns",
        .standards_control_description = "StandardsControlDescription",
        .standards_control_title = "StandardsControlTitle",
        .updated_at = "UpdatedAt",
        .updated_reason = "UpdatedReason",
    };
};
