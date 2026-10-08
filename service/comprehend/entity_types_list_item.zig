/// An entity type within a labeled training dataset that Amazon Comprehend uses
/// to train a
/// custom entity recognizer.
pub const EntityTypesListItem = struct {
    /// An entity type within a labeled training dataset that Amazon Comprehend uses
    /// to train a
    /// custom entity recognizer.
    ///
    /// Entity types must not contain the following invalid characters: \n (line
    /// break), \\n
    /// (escaped line break, \r (carriage return), \\r (escaped carriage return), \t
    /// (tab), \\t
    /// (escaped tab), and , (comma).
    type: []const u8,

    pub const json_field_names = .{
        .type = "Type",
    };
};
