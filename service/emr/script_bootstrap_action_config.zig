/// Configuration of the script to run during a bootstrap action.
pub const ScriptBootstrapActionConfig = struct {
    /// A list of command line arguments to pass to the bootstrap action script.
    args: ?[]const []const u8 = null,

    /// Location in Amazon S3 of the script to run during a bootstrap action.
    path: []const u8,

    pub const json_field_names = .{
        .args = "Args",
        .path = "Path",
    };
};
