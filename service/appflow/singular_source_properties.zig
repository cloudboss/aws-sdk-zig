/// The properties that are applied when Singular is being used as a source.
pub const SingularSourceProperties = struct {
    /// The object specified in the Singular flow source.
    object: []const u8,

    pub const json_field_names = .{
        .object = "object",
    };
};
