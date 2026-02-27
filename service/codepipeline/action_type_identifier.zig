const ActionCategory = @import("action_category.zig").ActionCategory;

/// Specifies the category, owner, provider, and version of the action type.
pub const ActionTypeIdentifier = struct {
    /// Defines what kind of action can be taken in the stage, one of the following:
    ///
    /// * `Source`
    ///
    /// * `Build`
    ///
    /// * `Test`
    ///
    /// * `Deploy`
    ///
    /// * `Approval`
    ///
    /// * `Invoke`
    category: ActionCategory,

    /// The creator of the action type being called: `AWS` or
    /// `ThirdParty`.
    owner: []const u8,

    /// The provider of the action type being called. The provider name is supplied
    /// when the
    /// action type is created.
    provider: []const u8,

    /// A string that describes the action type version.
    version: []const u8,

    pub const json_field_names = .{
        .category = "category",
        .owner = "owner",
        .provider = "provider",
        .version = "version",
    };
};
