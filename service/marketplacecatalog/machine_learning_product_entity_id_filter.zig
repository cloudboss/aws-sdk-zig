/// The filter for machine learning product entity IDs.
pub const MachineLearningProductEntityIdFilter = struct {
    /// A list of entity IDs to filter by. The operation returns machine learning
    /// products with entity IDs that match the values in this list.
    value_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};
