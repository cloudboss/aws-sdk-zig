/// An entity describing an executable that runs on a cluster.
pub const Command = struct {
    /// Arguments for Amazon EMR to pass to the command for execution.
    args: ?[]const []const u8 = null,

    /// The name of the command.
    name: ?[]const u8 = null,

    /// The Amazon S3 location of the command script.
    script_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .args = "Args",
        .name = "Name",
        .script_path = "ScriptPath",
    };
};
