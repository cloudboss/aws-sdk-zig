/// Represents the content of a `ConnectCase` related item.
pub const ConnectCaseInputContent = struct {
    /// A unique identifier of the case.
    case_id: []const u8,

    pub const json_field_names = .{
        .case_id = "caseId",
    };
};
