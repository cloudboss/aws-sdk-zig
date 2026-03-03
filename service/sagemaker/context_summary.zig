const ContextSource = @import("context_source.zig").ContextSource;

/// Lists a summary of the properties of a context. A context provides a logical
/// grouping of other entities.
pub const ContextSummary = struct {
    /// The Amazon Resource Name (ARN) of the context.
    context_arn: ?[]const u8 = null,

    /// The name of the context.
    context_name: ?[]const u8 = null,

    /// The type of the context.
    context_type: ?[]const u8 = null,

    /// When the context was created.
    creation_time: ?i64 = null,

    /// When the context was last modified.
    last_modified_time: ?i64 = null,

    /// The source of the context.
    source: ?ContextSource = null,

    pub const json_field_names = .{
        .context_arn = "ContextArn",
        .context_name = "ContextName",
        .context_type = "ContextType",
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
        .source = "Source",
    };
};
