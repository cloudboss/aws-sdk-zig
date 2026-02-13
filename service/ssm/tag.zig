/// Metadata that you assign to your Amazon Web Services resources. Tags enable
/// you to categorize your
/// resources in different ways, for example, by purpose, owner, or environment.
/// In Amazon Web Services Systems Manager, you
/// can apply tags to Systems Manager documents (SSM documents), managed nodes,
/// maintenance windows,
/// parameters, patch baselines, OpsItems, and OpsMetadata.
pub const Tag = struct {
    /// The name of the tag.
    key: []const u8,

    /// The value of the tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
