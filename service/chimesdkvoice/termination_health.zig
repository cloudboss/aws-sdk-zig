/// The termination health details, including the source IP address and
/// timestamp of the last successful `SIP OPTIONS` message from your SIP
/// infrastructure.
pub const TerminationHealth = struct {
    /// The source IP address.
    source: ?[]const u8,

    /// The timestamp, in ISO 8601 format.
    timestamp: ?i64,

    pub const json_field_names = .{
        .source = "Source",
        .timestamp = "Timestamp",
    };
};
