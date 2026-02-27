/// This action replaces the email envelope recipients with the given list of
/// recipients. If the condition of this action applies only to a subset of
/// recipients, only those recipients are replaced with the recipients specified
/// in the action. The message contents and headers are unaffected by this
/// action, only the envelope recipients are updated.
pub const ReplaceRecipientAction = struct {
    /// This action specifies the replacement recipient email addresses to insert.
    replace_with: ?[]const []const u8,

    pub const json_field_names = .{
        .replace_with = "ReplaceWith",
    };
};
