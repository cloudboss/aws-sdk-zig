const AttachmentsControlMode = @import("attachments_control_mode.zig").AttachmentsControlMode;

/// Configuration information for the file upload during chat feature.
pub const AttachmentsConfiguration = struct {
    /// Status information about whether file upload functionality is activated or
    /// deactivated for your end user.
    attachments_control_mode: AttachmentsControlMode,

    pub const json_field_names = .{
        .attachments_control_mode = "attachmentsControlMode",
    };
};
