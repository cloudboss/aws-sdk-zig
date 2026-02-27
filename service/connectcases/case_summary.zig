/// Case summary information.
pub const CaseSummary = struct {
    /// A unique identifier of the case.
    case_id: []const u8,

    /// A unique identifier of a template.
    template_id: []const u8,

    pub const json_field_names = .{
        .case_id = "caseId",
        .template_id = "templateId",
    };
};
