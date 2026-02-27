const DataBindingValue = @import("data_binding_value.zig").DataBindingValue;

/// Represents a data binding that matches the specified filter criteria.
pub const MatchedDataBinding = struct {
    /// The value of the matched data binding.
    value: DataBindingValue,

    pub const json_field_names = .{
        .value = "value",
    };
};
