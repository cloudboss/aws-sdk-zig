const Template = @import("template.zig").Template;

/// An object that contains the body of the message. You can specify a template
/// message.
pub const BulkEmailContent = struct {
    /// The template to use for the bulk email message.
    template: ?Template = null,

    pub const json_field_names = .{
        .template = "Template",
    };
};
