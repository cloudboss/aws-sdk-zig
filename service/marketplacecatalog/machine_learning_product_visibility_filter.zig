const MachineLearningProductVisibilityString = @import("machine_learning_product_visibility_string.zig").MachineLearningProductVisibilityString;

/// The filter for machine learning product visibility status.
pub const MachineLearningProductVisibilityFilter = struct {
    /// A list of visibility values to filter by. The operation returns machine
    /// learning products with visibility status that match the values in this list.
    value_list: ?[]const MachineLearningProductVisibilityString = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};
