const CommentFilter = @import("comment_filter.zig").CommentFilter;
const ConnectCaseFilter = @import("connect_case_filter.zig").ConnectCaseFilter;
const ContactFilter = @import("contact_filter.zig").ContactFilter;
const CustomFilter = @import("custom_filter.zig").CustomFilter;
const FileFilter = @import("file_filter.zig").FileFilter;
const SlaFilter = @import("sla_filter.zig").SlaFilter;

/// The list of types of related items and their parameters to use for
/// filtering.
pub const RelatedItemTypeFilter = union(enum) {
    /// A filter for related items of type `Comment`.
    comment: ?CommentFilter,
    /// Represents the Amazon Connect case to be created as a related item.
    connect_case: ?ConnectCaseFilter,
    /// A filter for related items of type `Contact`.
    contact: ?ContactFilter,
    /// Represents the content of a `Custom` type related item.
    custom: ?CustomFilter,
    /// A filter for related items of this type of `File`.
    file: ?FileFilter,
    /// Filter for related items of type `SLA`.
    sla: ?SlaFilter,

    pub const json_field_names = .{
        .comment = "comment",
        .connect_case = "connectCase",
        .contact = "contact",
        .custom = "custom",
        .file = "file",
        .sla = "sla",
    };
};
