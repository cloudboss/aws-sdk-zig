/// A list of `OutputAttribute` objects, each of which have the fields `Name`
/// and `Hashed`. Each of these objects selects a column to be included in the
/// output table, and whether the values of the column should be hashed.
pub const OutputAttribute = struct {
    /// Enables the ability to hash the column values in the output.
    hashed: ?bool,

    /// A name of a column to be written to the output. This must be an `InputField`
    /// name in the schema mapping.
    name: []const u8,

    pub const json_field_names = .{
        .hashed = "hashed",
        .name = "name",
    };
};
