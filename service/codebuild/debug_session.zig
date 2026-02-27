/// Contains information about the debug session for a build. For more
/// information, see [Viewing a
/// running build in Session
/// Manager](https://docs.aws.amazon.com/codebuild/latest/userguide/session-manager.html).
pub const DebugSession = struct {
    /// Specifies if session debugging is enabled for this build.
    session_enabled: ?bool,

    /// Contains the identifier of the Session Manager session used for the build.
    /// To work with
    /// the paused build, you open this session to examine, control, and resume the
    /// build.
    session_target: ?[]const u8,

    pub const json_field_names = .{
        .session_enabled = "sessionEnabled",
        .session_target = "sessionTarget",
    };
};
