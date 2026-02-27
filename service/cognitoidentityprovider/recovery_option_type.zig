const RecoveryOptionNameType = @import("recovery_option_name_type.zig").RecoveryOptionNameType;

/// A recovery option for a user. The `AccountRecoverySettingType` data type is
/// an array of this object. Each `RecoveryOptionType` has a priority property
/// that determines whether it is a primary or secondary option.
///
/// For example, if `verified_email` has a priority of `1` and
/// `verified_phone_number` has a priority of `2`, your user pool
/// sends account-recovery messages to a verified email address but falls back
/// to an SMS
/// message if the user has a verified phone number. The `admin_only` option
/// prevents self-service account recovery.
pub const RecoveryOptionType = struct {
    /// The recovery method that this object sets a recovery option for.
    name: RecoveryOptionNameType,

    /// Your priority preference for using the specified attribute in account
    /// recovery. The
    /// highest priority is `1`.
    priority: i32,

    pub const json_field_names = .{
        .name = "Name",
        .priority = "Priority",
    };
};
