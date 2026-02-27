/// Identifies a specific batch job.
pub const JobIdentifier = union(enum) {
    /// The name of the file that contains the batch job definition.
    file_name: ?[]const u8,
    /// The name of the script that contains the batch job definition.
    script_name: ?[]const u8,

    pub const json_field_names = .{
        .file_name = "fileName",
        .script_name = "scriptName",
    };
};
