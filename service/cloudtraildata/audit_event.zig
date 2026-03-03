/// An event from a source outside of Amazon Web Services that you want
/// CloudTrail
/// to log.
pub const AuditEvent = struct {
    /// The content of an audit event that comes from the event, such as
    /// `userIdentity`,
    /// `userAgent`, and `eventSource`.
    event_data: []const u8,

    /// A checksum is a base64-SHA256 algorithm that helps you verify that
    /// CloudTrail receives the event that matches
    /// with the checksum. Calculate the checksum by running a command like the
    /// following:
    ///
    /// `printf %s *$eventdata* | openssl dgst -binary -sha256 | base64`
    event_data_checksum: ?[]const u8 = null,

    /// The original event ID from the source event.
    id: []const u8,

    pub const json_field_names = .{
        .event_data = "eventData",
        .event_data_checksum = "eventDataChecksum",
        .id = "id",
    };
};
