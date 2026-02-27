/// The definition of the command to run when invoked as an alias or as an
/// action button.
pub const CustomActionDefinition = struct {
    /// The command string to run which may include variables by prefixing with a
    /// dollar sign ($).
    command_text: []const u8,

    pub const json_field_names = .{
        .command_text = "CommandText",
    };
};
