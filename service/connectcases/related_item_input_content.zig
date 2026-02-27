const CommentContent = @import("comment_content.zig").CommentContent;
const ConnectCaseInputContent = @import("connect_case_input_content.zig").ConnectCaseInputContent;
const Contact = @import("contact.zig").Contact;
const CustomInputContent = @import("custom_input_content.zig").CustomInputContent;
const FileContent = @import("file_content.zig").FileContent;
const SlaInputContent = @import("sla_input_content.zig").SlaInputContent;

/// Represents the content of a related item to be created.
pub const RelatedItemInputContent = union(enum) {
    /// Represents the content of a comment to be returned to agents.
    comment: ?CommentContent,
    /// Represents the Amazon Connect case to be created as a related item.
    connect_case: ?ConnectCaseInputContent,
    /// Object representing a contact in Amazon Connect as an API request field.
    contact: ?Contact,
    /// Represents the content of a `Custom` type related item.
    custom: ?CustomInputContent,
    /// A file of related items.
    file: ?FileContent,
    /// Represents the content of an SLA to be created.
    sla: ?SlaInputContent,

    pub const json_field_names = .{
        .comment = "comment",
        .connect_case = "connectCase",
        .contact = "contact",
        .custom = "custom",
        .file = "file",
        .sla = "sla",
    };
};
