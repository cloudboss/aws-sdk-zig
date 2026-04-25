const CommentUpdateContent = @import("comment_update_content.zig").CommentUpdateContent;
const CustomUpdateContent = @import("custom_update_content.zig").CustomUpdateContent;

/// Represents the content of a related item to be updated. This is a union type
/// that can contain either comment content or custom content.
pub const RelatedItemUpdateContent = union(enum) {
    comment: ?CommentUpdateContent,
    custom: ?CustomUpdateContent,

    pub const json_field_names = .{
        .comment = "comment",
        .custom = "custom",
    };
};
