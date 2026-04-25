const AssociationStatus = @import("association_status.zig").AssociationStatus;

/// An array that provides the enablement status and other details for each
/// control that
/// applies to each enabled standard.
pub const StandardsControlAssociationSummary = struct {
    /// The enablement status of a control in a specific standard.
    association_status: AssociationStatus,

    /// The requirement that underlies this control in the compliance framework
    /// related to the standard.
    related_requirements: ?[]const []const u8 = null,

    /// The ARN of a control, such as
    /// `arn:aws:securityhub:eu-central-1:123456789012:security-control/S3.1`. This
    /// parameter doesn't mention a specific standard.
    security_control_arn: []const u8,

    /// A unique standard-agnostic identifier for a control. Values for this field
    /// typically consist of an
    /// Amazon Web Services service and a number, such as APIGateway.5. This field
    /// doesn't reference a specific standard.
    security_control_id: []const u8,

    /// The Amazon Resource Name (ARN) of a standard.
    standards_arn: []const u8,

    /// The description of a control. This typically summarizes how Security Hub
    /// CSPM evaluates the control and the
    /// conditions under which it produces a failed finding. The parameter may
    /// reference a specific standard.
    standards_control_description: ?[]const u8 = null,

    /// The title of a control.
    standards_control_title: ?[]const u8 = null,

    /// The last time that a control's enablement status in a specified standard was
    /// updated.
    updated_at: ?i64 = null,

    /// The reason for updating a control's enablement status in a specified
    /// standard.
    updated_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_status = "AssociationStatus",
        .related_requirements = "RelatedRequirements",
        .security_control_arn = "SecurityControlArn",
        .security_control_id = "SecurityControlId",
        .standards_arn = "StandardsArn",
        .standards_control_description = "StandardsControlDescription",
        .standards_control_title = "StandardsControlTitle",
        .updated_at = "UpdatedAt",
        .updated_reason = "UpdatedReason",
    };
};
