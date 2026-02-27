const AssociationStatus = @import("association_status.zig").AssociationStatus;

/// An array of requested updates to the enablement status of controls in
/// specified
/// standards. The objects in the array include a security control ID, the
/// Amazon Resource Name (ARN) of the standard, the requested
/// enablement status, and the reason for updating the enablement status.
pub const StandardsControlAssociationUpdate = struct {
    /// The desired enablement status of the control in the standard.
    association_status: AssociationStatus,

    /// The unique identifier for the security control whose enablement status you
    /// want to update.
    security_control_id: []const u8,

    /// The Amazon Resource Name (ARN) of the standard in which you want to update
    /// the
    /// control's enablement status.
    standards_arn: []const u8,

    /// The reason for updating the control's enablement status in the standard.
    updated_reason: ?[]const u8,

    pub const json_field_names = .{
        .association_status = "AssociationStatus",
        .security_control_id = "SecurityControlId",
        .standards_arn = "StandardsArn",
        .updated_reason = "UpdatedReason",
    };
};
