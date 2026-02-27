/// Corresponds to the archive_allowed parameter. A value of ARCHIVE_NOT_ALLOWED
/// corresponds to 0 (false) in the SCTE-35 specification. If you include one of
/// the "restriction" flags then you must include all four of them.
pub const Scte35ArchiveAllowedFlag = enum {
    archive_not_allowed,
    archive_allowed,

    pub const json_field_names = .{
        .archive_not_allowed = "ARCHIVE_NOT_ALLOWED",
        .archive_allowed = "ARCHIVE_ALLOWED",
    };
};
