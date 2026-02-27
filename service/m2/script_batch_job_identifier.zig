/// A batch job identifier in which the batch job to run is identified by the
/// script
/// name.
pub const ScriptBatchJobIdentifier = struct {
    /// The name of the script containing the batch job definition.
    script_name: []const u8,

    pub const json_field_names = .{
        .script_name = "scriptName",
    };
};
