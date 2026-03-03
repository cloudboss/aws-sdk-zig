/// Contains information about the reasoning why a check for access passed or
/// failed.
pub const ReasonSummary = struct {
    /// A description of the reasoning of a result of checking for access.
    description: ?[]const u8 = null,

    /// The identifier for the reason statement.
    statement_id: ?[]const u8 = null,

    /// The index number of the reason statement.
    statement_index: ?i32 = null,

    pub const json_field_names = .{
        .description = "description",
        .statement_id = "statementId",
        .statement_index = "statementIndex",
    };
};
