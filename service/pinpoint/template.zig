/// Specifies the name and version of the message template to use for the
/// message.
pub const Template = struct {
    /// The name of the message template to use for the message. If specified, this
    /// value must match the name of an existing message template.
    name: ?[]const u8 = null,

    /// The unique identifier for the version of the message template to use for the
    /// message. If specified, this value must match the identifier for an existing
    /// template version. To retrieve a list of versions and version identifiers for
    /// a template, use the Template Versions resource.
    ///
    /// If you don't specify a value for this property, Amazon Pinpoint uses the
    /// *active version* of the template. The *active version* is typically the
    /// version of a template that's been most recently reviewed and approved for
    /// use, depending on your workflow. It isn't necessarily the latest version of
    /// a template.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .version = "Version",
    };
};
