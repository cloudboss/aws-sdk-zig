/// Properties associated with the columns participating in a join.
pub const JoinKeyProperties = struct {
    /// A value that indicates that a row in a table is uniquely identified by the
    /// columns in
    /// a join key. This is used by Quick Sight to optimize query performance.
    unique_key: ?bool,

    pub const json_field_names = .{
        .unique_key = "UniqueKey",
    };
};
