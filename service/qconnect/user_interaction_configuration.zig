/// Configuration for user interaction settings.
pub const UserInteractionConfiguration = struct {
    /// Indicates whether user confirmation is required for the interaction.
    is_user_confirmation_required: ?bool = null,

    pub const json_field_names = .{
        .is_user_confirmation_required = "isUserConfirmationRequired",
    };
};
