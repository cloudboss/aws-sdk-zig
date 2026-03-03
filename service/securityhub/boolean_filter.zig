/// Boolean filter for querying findings.
pub const BooleanFilter = struct {
    /// The value of the boolean.
    value: ?bool = null,

    pub const json_field_names = .{
        .value = "Value",
    };
};
