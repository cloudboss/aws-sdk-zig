/// The Cybersecurity and Infrastructure Security Agency (CISA) details for a
/// specific
/// vulnerability.
pub const CisaData = struct {
    /// The remediation action recommended by CISA for this vulnerability.
    action: ?[]const u8 = null,

    /// The date and time CISA added this vulnerability to their catalogue.
    date_added: ?i64 = null,

    /// The date and time CISA expects a fix to have been provided vulnerability.
    date_due: ?i64 = null,

    pub const json_field_names = .{
        .action = "action",
        .date_added = "dateAdded",
        .date_due = "dateDue",
    };
};
