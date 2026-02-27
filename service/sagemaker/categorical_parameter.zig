/// Environment parameters you want to benchmark your load test against.
pub const CategoricalParameter = struct {
    /// The Name of the environment variable.
    name: []const u8,

    /// The list of values you can pass.
    value: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
