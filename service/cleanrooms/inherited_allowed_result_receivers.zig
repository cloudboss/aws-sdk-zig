const InheritedAllowedResultReceiversSource = @import("inherited_allowed_result_receivers_source.zig").InheritedAllowedResultReceiversSource;

/// Contains the inherited allowed result receivers constraint and its sources
/// from parent tables.
pub const InheritedAllowedResultReceivers = struct {
    /// The list of parent tables that contribute to this inherited constraint.
    sources: []const InheritedAllowedResultReceiversSource,

    /// The effective list of Amazon Web Services account IDs allowed to receive
    /// results, inherited from parent tables.
    value: []const []const u8,

    pub const json_field_names = .{
        .sources = "sources",
        .value = "value",
    };
};
