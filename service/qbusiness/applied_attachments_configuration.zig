const AttachmentsControlMode = @import("attachments_control_mode.zig").AttachmentsControlMode;

/// Configuration information about the file upload during chat feature for your
/// application.
pub const AppliedAttachmentsConfiguration = struct {
    /// Information about whether file upload during chat functionality is activated
    /// for your application.
    attachments_control_mode: ?AttachmentsControlMode = null,

    pub const json_field_names = .{
        .attachments_control_mode = "attachmentsControlMode",
    };
};
