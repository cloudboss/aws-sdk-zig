/// A batch job definition contained in a script.
pub const ScriptBatchJobDefinition = struct {
    /// The name of the script containing the batch job definition.
    script_name: []const u8,

    pub const json_field_names = .{
        .script_name = "scriptName",
    };
};
