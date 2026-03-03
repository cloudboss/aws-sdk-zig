/// Information about the suggested code fix to remediate a finding.
pub const SuggestedFix = struct {
    /// The suggested code fix. If applicable, includes code patch to replace your
    /// source code.
    code: ?[]const u8 = null,

    /// A description of the suggested code fix and why it is being suggested.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .description = "description",
    };
};
