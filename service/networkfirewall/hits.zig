/// Attempts made to a access domain.
pub const Hits = struct {
    /// The number of attempts made to access a domain.
    count: i32 = 0,

    pub const json_field_names = .{
        .count = "Count",
    };
};
