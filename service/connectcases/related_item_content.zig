const CommentContent = @import("comment_content.zig").CommentContent;
const ConnectCaseContent = @import("connect_case_content.zig").ConnectCaseContent;
const ContactContent = @import("contact_content.zig").ContactContent;
const CustomContent = @import("custom_content.zig").CustomContent;
const FileContent = @import("file_content.zig").FileContent;
const SlaContent = @import("sla_content.zig").SlaContent;

/// Represents the content of a particular type of related item.
pub const RelatedItemContent = union(enum) {
    /// Represents the content of a comment to be returned to agents.
    comment: ?CommentContent,
    /// Represents the Amazon Connect case to be created as a related item.
    connect_case: ?ConnectCaseContent,
    /// Represents the content of a contact to be returned to agents.
    contact: ?ContactContent,
    /// Represents the content of a `Custom` type related item.
    custom: ?CustomContent,
    /// Represents the content of a File to be returned to agents.
    file: ?FileContent,
    /// Represents the content of an SLA to be returned to agents.
    sla: ?SlaContent,

    pub const json_field_names = .{
        .comment = "comment",
        .connect_case = "connectCase",
        .contact = "contact",
        .custom = "custom",
        .file = "file",
        .sla = "sla",
    };
};
