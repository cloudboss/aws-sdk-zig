/// The trait associated with the remediation target.
pub const RemediationTrait = struct {
    /// The trait title.
    title: []const u8,

    /// The trait type.
    type: []const u8,

    pub const json_field_names = .{
        .title = "Title",
        .type = "Type",
    };
};
