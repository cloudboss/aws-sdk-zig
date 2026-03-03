const ExpressionType = @import("expression_type.zig").ExpressionType;
const InputSerialization = @import("input_serialization.zig").InputSerialization;
const OutputSerialization = @import("output_serialization.zig").OutputSerialization;

/// Contains information about the parameters used for a select.
pub const SelectParameters = struct {
    /// The expression that is used to select the object.
    expression: ?[]const u8 = null,

    /// The type of the provided expression, for example `SQL`.
    expression_type: ?ExpressionType = null,

    /// Describes the serialization format of the object.
    input_serialization: ?InputSerialization = null,

    /// Describes how the results of the select job are serialized.
    output_serialization: ?OutputSerialization = null,

    pub const json_field_names = .{
        .expression = "Expression",
        .expression_type = "ExpressionType",
        .input_serialization = "InputSerialization",
        .output_serialization = "OutputSerialization",
    };
};
