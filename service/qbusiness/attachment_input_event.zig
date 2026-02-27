const AttachmentInput = @import("attachment_input.zig").AttachmentInput;

/// A file input event activated by a end user request to upload files into
/// their web experience chat.
pub const AttachmentInputEvent = struct {
    attachment: ?AttachmentInput,

    pub const json_field_names = .{
        .attachment = "attachment",
    };
};
