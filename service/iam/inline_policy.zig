/// Contains an inline policy template that the service embeds in roles that you
/// create from a
/// role template.
pub const InlinePolicy = struct {
    /// The inline policy document.
    policy_document: []const u8,

    /// The name of the inline policy.
    policy_name: []const u8,
};
