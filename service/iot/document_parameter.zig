/// A map of key-value pairs containing the patterns that need to be replaced in
/// a managed
/// template job document schema. You can use the description of each key as a
/// guidance to
/// specify the inputs during runtime when creating a job.
///
/// `documentParameters` can only be used when creating jobs from Amazon Web
/// Services
/// managed templates. This parameter can't be used with custom job templates or
/// to
/// create jobs from them.
pub const DocumentParameter = struct {
    /// Description of the map field containing the patterns that need to be
    /// replaced in a
    /// managed template job document schema.
    description: ?[]const u8,

    /// An example illustrating a pattern that need to be replaced in a managed
    /// template job
    /// document schema.
    example: ?[]const u8,

    /// Key of the map field containing the patterns that need to be replaced in a
    /// managed
    /// template job document schema.
    key: ?[]const u8,

    /// Specifies whether a pattern that needs to be replaced in a managed template
    /// job
    /// document schema is optional or required.
    optional: bool = false,

    /// A regular expression of the patterns that need to be replaced in a managed
    /// template
    /// job document schema.
    regex: ?[]const u8,

    pub const json_field_names = .{
        .description = "description",
        .example = "example",
        .key = "key",
        .optional = "optional",
        .regex = "regex",
    };
};
