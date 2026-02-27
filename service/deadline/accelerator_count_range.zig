/// Defines the maximum and minimum number of GPU accelerators required for a
/// worker instance..
pub const AcceleratorCountRange = struct {
    /// The maximum number of GPU accelerators in the worker host.
    max: ?i32,

    /// The minimum number of GPU accelerators in the worker host.
    min: i32,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
    };
};
