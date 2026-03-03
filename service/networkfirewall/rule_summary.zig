/// A complex type containing details about a Suricata rule. Contains:
///
/// * `SID`
///
/// * `Msg`
///
/// * `Metadata`
///
/// Summaries are available for rule groups you manage and for active threat
/// defense Amazon Web Services managed rule groups.
pub const RuleSummary = struct {
    /// The contents of the rule's metadata.
    metadata: ?[]const u8 = null,

    /// The contents taken from the rule's msg field.
    msg: ?[]const u8 = null,

    /// The unique identifier (Signature ID) of the Suricata rule.
    sid: ?[]const u8 = null,

    pub const json_field_names = .{
        .metadata = "Metadata",
        .msg = "Msg",
        .sid = "SID",
    };
};
