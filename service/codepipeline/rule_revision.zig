/// The change to a rule that creates a revision of the rule.
pub const RuleRevision = struct {
    /// The date and time when the most recent version of the rule was created, in
    /// timestamp
    /// format.
    created: i64,

    /// The unique identifier of the change that set the state to this revision (for
    /// example,
    /// a deployment ID or timestamp).
    revision_change_id: []const u8,

    /// The system-generated unique ID that identifies the revision number of the
    /// rule.
    revision_id: []const u8,

    pub const json_field_names = .{
        .created = "created",
        .revision_change_id = "revisionChangeId",
        .revision_id = "revisionId",
    };
};
