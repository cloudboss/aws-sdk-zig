/// Describes a web-based, remote graphical user interface (GUI), Amazon DCV
/// session. The
/// session is used to access a virtual computer’s operating system or
/// application.
pub const Session = struct {
    /// When true, this Boolean value indicates the primary session for the
    /// specified
    /// resource.
    is_primary: ?bool,

    /// The session name.
    name: ?[]const u8,

    /// The session URL.
    url: ?[]const u8,

    pub const json_field_names = .{
        .is_primary = "isPrimary",
        .name = "name",
        .url = "url",
    };
};
