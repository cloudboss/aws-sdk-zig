/// A position in a policy.
pub const Position = struct {
    /// The column of the position, starting from 0.
    column: i32,

    /// The line of the position, starting from 1.
    line: i32,

    /// The offset within the policy that corresponds to the position, starting from
    /// 0.
    offset: i32,

    pub const json_field_names = .{
        .column = "column",
        .line = "line",
        .offset = "offset",
    };
};
