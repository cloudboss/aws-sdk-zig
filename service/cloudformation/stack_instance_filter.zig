const StackInstanceFilterName = @import("stack_instance_filter_name.zig").StackInstanceFilterName;

/// The filter to apply to stack instances
pub const StackInstanceFilter = struct {
    /// The type of filter to apply.
    name: ?StackInstanceFilterName,

    /// The status to filter by.
    values: ?[]const u8,
};
