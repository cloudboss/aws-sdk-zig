const CommunicationMode = @import("communication_mode.zig").CommunicationMode;

/// Specifies the configuration for a single SFTP port on a Transfer Family
/// server that uses the SFTP protocol and has a `PUBLIC` endpoint. Each entry
/// in the `SftpPorts` list is an `SftpPortWithOptions` object that pairs a port
/// number with a communication mode.
pub const SftpPortWithOptions = struct {
    /// Determines whether the server or the client sends data first when a client
    /// establishes an SFTP connection on this port. Valid values are
    /// `SERVER_TALK_FIRST` and `CLIENT_TALK_FIRST`. For a description of each mode,
    /// see the `SftpPorts` property. This value is optional.
    communication_mode: ?CommunicationMode = null,

    /// The port on which the Transfer Family server listens for SFTP connections.
    /// Specify any integer from 2000 to 65535, or 22. This value is required for
    /// each entry in the `SftpPorts` list.
    sftp_port: i32,

    pub const json_field_names = .{
        .communication_mode = "CommunicationMode",
        .sftp_port = "SftpPort",
    };
};
