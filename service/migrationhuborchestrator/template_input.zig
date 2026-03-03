const DataType = @import("data_type.zig").DataType;

/// The input parameters of a template.
pub const TemplateInput = struct {
    /// The data type of the template input.
    data_type: ?DataType = null,

    /// The name of the template.
    input_name: ?[]const u8 = null,

    /// Determine if an input is required from the template.
    required: ?bool = null,

    pub const json_field_names = .{
        .data_type = "dataType",
        .input_name = "inputName",
        .required = "required",
    };
};
