const RecoveryOptionType = @import("recovery_option_type.zig").RecoveryOptionType;

/// The settings for user message delivery in forgot-password operations.
/// Contains
/// preference for email or SMS message delivery of password reset codes, or for
/// admin-only
/// password reset.
pub const AccountRecoverySettingType = struct {
    /// The list of options and priorities for user message delivery in
    /// forgot-password
    /// operations. Sets or displays user pool preferences for email or SMS message
    /// priority,
    /// whether users should fall back to a second delivery method, and whether
    /// passwords should
    /// only be reset by administrators.
    recovery_mechanisms: ?[]const RecoveryOptionType = null,

    pub const json_field_names = .{
        .recovery_mechanisms = "RecoveryMechanisms",
    };
};
