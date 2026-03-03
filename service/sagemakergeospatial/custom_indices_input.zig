const Operation = @import("operation.zig").Operation;

/// Input object defining the custom BandMath indices to compute.
pub const CustomIndicesInput = struct {
    /// A list of BandMath indices to compute.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .operations = "Operations",
    };
};
