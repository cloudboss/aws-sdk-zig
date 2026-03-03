/// A conditional statement for filtering a list of past predictions.
pub const FilterCondition = struct {
    /// A statement containing a resource property and a value to specify filter
    /// condition.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .value = "value",
    };
};
