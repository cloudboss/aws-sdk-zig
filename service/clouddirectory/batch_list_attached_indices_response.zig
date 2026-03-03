const IndexAttachment = @import("index_attachment.zig").IndexAttachment;

/// Represents the output of a ListAttachedIndices response operation.
pub const BatchListAttachedIndicesResponse = struct {
    /// The indices attached to the specified object.
    index_attachments: ?[]const IndexAttachment = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .index_attachments = "IndexAttachments",
        .next_token = "NextToken",
    };
};
