/// A subject structure.
pub const SubjectStructure = struct {
    /// Number of occurrences of this specific structure.
    count: ?i64,

    /// A list of predicates present in this specific structure.
    predicates: ?[]const []const u8,

    pub const json_field_names = .{
        .count = "count",
        .predicates = "predicates",
    };
};
