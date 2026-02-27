/// The Cost Categories values used for filtering the costs.
pub const CostCategoryValues = struct {
    /// The unique name of the Cost Category.
    key: []const u8,

    /// The specific value of the Cost Category.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "key",
        .values = "values",
    };
};
