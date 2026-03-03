/// Action required for a broker.
pub const ActionRequired = struct {
    /// The code you can use to find instructions on the action required to resolve
    /// your broker issue.
    action_required_code: ?[]const u8 = null,

    /// Information about the action required to resolve your broker issue.
    action_required_info: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_required_code = "ActionRequiredCode",
        .action_required_info = "ActionRequiredInfo",
    };
};
