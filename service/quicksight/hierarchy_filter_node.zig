const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;

/// A node in the selection tree of a `HierarchyFilter`. Each node records the
/// values that are selected at one level of the hierarchy. Nodes nest through
/// `Children` to record selections at deeper levels.
///
/// The tree cannot be deeper than the number of levels declared in
/// `HierarchyLevels`. A tree can be a maximum of 5 levels deep, and a node can
/// have a maximum of 1,000 children.
pub const HierarchyFilterNode = struct {
    /// The nodes that record the selections at the next level of the hierarchy. You
    /// can
    /// specify a maximum of 1,000 children per node.
    children: ?[]const HierarchyFilterNode = null,

    /// The column that this node selects values from. This column must match the
    /// column of the
    /// corresponding level in `HierarchyFilter$HierarchyLevels`. The node at depth
    /// 1
    /// must match the first level, the node at depth 2 must match the second level,
    /// and so on.
    column: ColumnIdentifier,

    /// The values that are selected at this level of the hierarchy. You can specify
    /// a maximum
    /// of 2,000 values per node.
    hierarchy_values: ?[]const []const u8 = null,

    /// The value in the parent node's `HierarchyValues` that this node belongs to.
    /// When a parent selects several values, each of its children repeats one of
    /// them here to
    /// identify which branch of the hierarchy that child describes.
    ///
    /// Omit this attribute on the root node of `HierarchyTree`, which has no
    /// parent.
    parent_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .children = "Children",
        .column = "Column",
        .hierarchy_values = "HierarchyValues",
        .parent_value = "ParentValue",
    };
};
