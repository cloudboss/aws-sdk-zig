const AccessPreviewStatusReasonCode = @import("access_preview_status_reason_code.zig").AccessPreviewStatusReasonCode;

/// Provides more details about the current status of the access preview. For
/// example, if the creation of the access preview fails, a `Failed` status is
/// returned. This failure can be due to an internal issue with the analysis or
/// due to an invalid proposed resource configuration.
pub const AccessPreviewStatusReason = struct {
    /// The reason code for the current status of the access preview.
    code: AccessPreviewStatusReasonCode,

    pub const json_field_names = .{
        .code = "code",
    };
};
