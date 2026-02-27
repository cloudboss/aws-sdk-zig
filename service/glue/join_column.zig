/// Specifies a column to be joined.
pub const JoinColumn = struct {
    /// The column to be joined.
    from: []const u8,

    /// The key of the column to be joined.
    keys: []const []const []const u8,

    pub const json_field_names = .{
        .from = "From",
        .keys = "Keys",
    };
};
