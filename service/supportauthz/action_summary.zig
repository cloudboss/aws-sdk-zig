/// A summary of a support action.
pub const ActionSummary = struct {
    /// The name of the support action.
    action: []const u8,

    /// A description of what the support action does.
    description: []const u8,

    /// The AWS service associated with the support action.
    service: []const u8,

    pub const json_field_names = .{
        .action = "action",
        .description = "description",
        .service = "service",
    };
};
