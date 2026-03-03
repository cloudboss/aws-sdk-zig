const RelationshipType = @import("relationship_type.zig").RelationshipType;

/// Information about how blocks are related to each other. A `Block` object
/// contains 0 or more `Relation` objects in a list, `Relationships`. For
/// more information, see Block.
///
/// The `Type` element provides the type of the relationship for all blocks in
/// the `IDs` array.
pub const Relationship = struct {
    /// An
    /// array of IDs for related blocks. You can get the type of the relationship
    /// from the
    /// `Type` element.
    ids: ?[]const []const u8 = null,

    /// The type of relationship between the blocks in the IDs array and the current
    /// block. The
    /// following list describes the relationship types that can be returned.
    ///
    /// * *VALUE* - A list that contains the ID of the VALUE block that's associated
    ///   with the
    /// KEY of a key-value pair.
    ///
    /// * *CHILD* - A list of IDs that identify blocks found within the
    /// current block object. For example, WORD blocks have a CHILD relationship to
    /// the LINE
    /// block type.
    ///
    /// * *MERGED_CELL* - A list of IDs that identify each of the
    /// MERGED_CELL block types in a table.
    ///
    /// * *ANSWER* - A list that contains the ID of the QUERY_RESULT
    /// block that’s associated with the corresponding QUERY block.
    ///
    /// * *TABLE* - A list of IDs that identify associated TABLE block
    /// types.
    ///
    /// * *TABLE_TITLE* - A list that contains the ID for the TABLE_TITLE
    /// block type in a table.
    ///
    /// * *TABLE_FOOTER* - A list of IDs that identify the TABLE_FOOTER
    /// block types in a table.
    @"type": ?RelationshipType = null,

    pub const json_field_names = .{
        .ids = "Ids",
        .@"type" = "Type",
    };
};
