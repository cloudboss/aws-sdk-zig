/// A context that must be active for an intent to be
/// selected by Amazon Lex.
pub const InputContext = struct {
    /// The name of the context.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
