/// A filter for related items of type `ConnectCase`.
pub const ConnectCaseFilter = struct {
    /// A unique identifier of the case.
    case_id: ?[]const u8,

    pub const json_field_names = .{
        .case_id = "caseId",
    };
};
