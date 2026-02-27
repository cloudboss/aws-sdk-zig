const IndexAttachment = @import("index_attachment.zig").IndexAttachment;

/// Represents the output of a ListIndex response operation.
pub const BatchListIndexResponse = struct {
    /// The objects and indexed values attached to the index.
    index_attachments: ?[]const IndexAttachment,

    /// The pagination token.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .index_attachments = "IndexAttachments",
        .next_token = "NextToken",
    };
};
