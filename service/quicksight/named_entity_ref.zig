/// The definition for a `NamedEntityRef`.
pub const NamedEntityRef = struct {
    /// The `NamedEntityName` for the `NamedEntityRef`.
    named_entity_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .named_entity_name = "NamedEntityName",
    };
};
