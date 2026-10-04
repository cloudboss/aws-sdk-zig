const InputSource = @import("input_source.zig").InputSource;
const InquiryStatus = @import("inquiry_status.zig").InquiryStatus;
const InquiryStatusMessage = @import("inquiry_status_message.zig").InquiryStatusMessage;
const InquirySupportMode = @import("inquiry_support_mode.zig").InquirySupportMode;

/// Detailed information about a compliance inquiry.
pub const InquiryDetail = struct {
    /// ARN of the compliance inquiry resource.
    arn: []const u8,

    /// Timestamp indicating when the resource was created.
    created_at: i64,

    /// Unique resource ID for the compliance inquiry.
    id: []const u8,

    /// Type of inquiry content (text or file).
    input_source: InputSource,

    /// Title of the inquiry.
    name: []const u8,

    /// Current processing status of the inquiry.
    status: InquiryStatus,

    /// Status message providing additional context.
    status_message: InquiryStatusMessage,

    /// Support mode for this inquiry. AI_ONLY provides AI-generated responses.
    /// FULL_SUPPORT includes human expert review.
    support_mode: ?InquirySupportMode = null,

    /// Timestamp indicating when the resource was last modified.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .id = "id",
        .input_source = "inputSource",
        .name = "name",
        .status = "status",
        .status_message = "statusMessage",
        .support_mode = "supportMode",
        .updated_at = "updatedAt",
    };
};
