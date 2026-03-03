/// Contains configuration information for the calculation.
pub const CalculationConfiguration = struct {
    /// A string that contains the code for the calculation.
    code_block: ?[]const u8 = null,

    pub const json_field_names = .{
        .code_block = "CodeBlock",
    };
};
