/// An annotation that provides additional context or metadata.
pub const Annotation = struct {
    /// A hint indicating that the annotation contains potentially destructive
    /// content.
    destructive_hint: ?bool = null,

    /// The title of the annotation.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .destructive_hint = "destructiveHint",
        .title = "title",
    };
};
