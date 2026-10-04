/// One step within a remediation procedure.
pub const RemediationStep = struct {
    /// The content describing the step, which can include code examples and
    /// verification checklists.
    content: []const u8,

    /// An optional short label for the step.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .content = "content",
        .title = "title",
    };
};
