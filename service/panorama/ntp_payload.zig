/// Network time protocol (NTP) server settings. Use this option to connect to
/// local NTP servers instead of
/// `pool.ntp.org`.
pub const NtpPayload = struct {
    /// NTP servers to use, in order of preference.
    ntp_servers: []const []const u8,

    pub const json_field_names = .{
        .ntp_servers = "NtpServers",
    };
};
