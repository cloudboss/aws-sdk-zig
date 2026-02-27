pub const AutomatedReasoningPolicyBuildDocumentContentType = enum {
    pdf,
    text,

    pub const json_field_names = .{
        .pdf = "PDF",
        .text = "TEXT",
    };
};
