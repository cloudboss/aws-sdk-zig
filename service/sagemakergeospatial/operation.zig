const OutputType = @import("output_type.zig").OutputType;

/// Represents an arithmetic operation to compute spectral index.
pub const Operation = struct {
    /// Textual representation of the math operation; Equation used to compute the
    /// spectral index.
    equation: []const u8,

    /// The name of the operation.
    name: []const u8,

    /// The type of the operation.
    output_type: ?OutputType,

    pub const json_field_names = .{
        .equation = "Equation",
        .name = "Name",
        .output_type = "OutputType",
    };
};
