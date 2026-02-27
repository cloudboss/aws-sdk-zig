const PersonalizationControlMode = @import("personalization_control_mode.zig").PersonalizationControlMode;

/// Configuration information about chat response personalization. For more
/// information, see [Personalizing chat
/// responses](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/personalizing-chat-responses.html).
pub const PersonalizationConfiguration = struct {
    /// An option to allow Amazon Q Business to customize chat responses using user
    /// specific metadata—specifically, location and job information—in your IAM
    /// Identity Center instance.
    personalization_control_mode: PersonalizationControlMode,

    pub const json_field_names = .{
        .personalization_control_mode = "personalizationControlMode",
    };
};
