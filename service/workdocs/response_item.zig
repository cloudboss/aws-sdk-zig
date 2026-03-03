const CommentMetadata = @import("comment_metadata.zig").CommentMetadata;
const DocumentMetadata = @import("document_metadata.zig").DocumentMetadata;
const DocumentVersionMetadata = @import("document_version_metadata.zig").DocumentVersionMetadata;
const FolderMetadata = @import("folder_metadata.zig").FolderMetadata;
const ResponseItemType = @import("response_item_type.zig").ResponseItemType;

/// List of Documents, Folders, Comments, and Document Versions matching the
/// query.
pub const ResponseItem = struct {
    /// The comment that matches the query.
    comment_metadata: ?CommentMetadata = null,

    /// The document that matches the query.
    document_metadata: ?DocumentMetadata = null,

    /// The document version that matches the metadata.
    document_version_metadata: ?DocumentVersionMetadata = null,

    /// The folder that matches the query.
    folder_metadata: ?FolderMetadata = null,

    /// The type of item being returned.
    resource_type: ?ResponseItemType = null,

    /// The webUrl of the item being returned.
    web_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .comment_metadata = "CommentMetadata",
        .document_metadata = "DocumentMetadata",
        .document_version_metadata = "DocumentVersionMetadata",
        .folder_metadata = "FolderMetadata",
        .resource_type = "ResourceType",
        .web_url = "WebUrl",
    };
};
