/// An identifier that references an extraction definition resource.
pub const RulesExtractionDefinitionIdentifier = struct {
    /// The identifier of the extraction definition.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};
