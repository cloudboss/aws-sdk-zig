const Compute = @import("compute.zig").Compute;

/// Describes the compute type of the bundle.
pub const ComputeType = struct {
    /// The compute type.
    name: ?Compute,

    pub const json_field_names = .{
        .name = "Name",
    };
};
