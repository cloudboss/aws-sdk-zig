/// A knowledge source that provides content for recommendations.
pub const KnowledgeSource = union(enum) {
    /// The list of assistant association identifiers for the knowledge source.
    assistant_association_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .assistant_association_ids = "assistantAssociationIds",
    };
};
