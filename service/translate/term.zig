/// The term being translated by the custom terminology.
pub const Term = struct {
    /// The source text of the term being translated by the custom terminology.
    source_text: ?[]const u8 = null,

    /// The target text of the term being translated by the custom terminology.
    target_text: ?[]const u8 = null,

    pub const json_field_names = .{
        .source_text = "SourceText",
        .target_text = "TargetText",
    };
};
