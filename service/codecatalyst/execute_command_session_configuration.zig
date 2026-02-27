/// Information about the commands that will be run on a Dev Environment when an
/// SSH session begins.
pub const ExecuteCommandSessionConfiguration = struct {
    /// An array of arguments containing arguments and members.
    arguments: ?[]const []const u8,

    /// The command used at the beginning of the SSH session to a Dev Environment.
    command: []const u8,

    pub const json_field_names = .{
        .arguments = "arguments",
        .command = "command",
    };
};
