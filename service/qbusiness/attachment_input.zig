const CopyFromSource = @import("copy_from_source.zig").CopyFromSource;

/// This is either a file directly uploaded into a web experience chat or a
/// reference to an existing attachment that is part of a web experience chat.
pub const AttachmentInput = struct {
    /// A reference to an existing attachment.
    copy_from: ?CopyFromSource = null,

    /// The contents of the attachment.
    data: ?[]const u8 = null,

    /// The filename of the attachment.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .copy_from = "copyFrom",
        .data = "data",
        .name = "name",
    };
};
