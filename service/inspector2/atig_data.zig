/// The Amazon Web Services Threat Intel Group (ATIG) details for a specific
/// vulnerability.
pub const AtigData = struct {
    /// The date and time this vulnerability was first observed.
    first_seen: ?i64,

    /// The date and time this vulnerability was last observed.
    last_seen: ?i64,

    /// The commercial sectors this vulnerability targets.
    targets: ?[]const []const u8,

    /// The [MITRE ATT&CK](https://attack.mitre.org/) tactics, techniques,
    /// and procedures (TTPs) associated with vulnerability.
    ttps: ?[]const []const u8,

    pub const json_field_names = .{
        .first_seen = "firstSeen",
        .last_seen = "lastSeen",
        .targets = "targets",
        .ttps = "ttps",
    };
};
