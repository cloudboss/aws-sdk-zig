/// Options that apply when the app starts. These options override default
/// behavior.
pub const LaunchOverrides = struct {
    /// App launch commands and command line parameters that override the launch
    /// command
    /// configured in the simulation schema.
    launch_commands: ?[]const []const u8,

    pub const json_field_names = .{
        .launch_commands = "LaunchCommands",
    };
};
