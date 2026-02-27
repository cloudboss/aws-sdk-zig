/// Represents the content of a `ConnectCase` type related item.
pub const ConnectCaseContent = struct {
    /// A unique identifier of the case.
    case_id: []const u8,

    pub const json_field_names = .{
        .case_id = "caseId",
    };
};
