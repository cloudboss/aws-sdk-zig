const CodeType = @import("code_type.zig").CodeType;

/// The loose variant of the passcode policy parameters that is used only when
/// you update a notify code configuration. When you omit a member, its current
/// value is preserved.
pub const UpdateCodeConfigurationParameters = struct {
    /// The updated number of characters in the one-time passcode. Valid values
    /// range from 4 through 8. Omit this member to preserve the current value.
    code_length: ?i32 = null,

    /// The updated character set used to generate the one-time passcode. Omit this
    /// member to preserve the current value.
    code_type: ?CodeType = null,

    /// The updated maximum number of validation attempts that are allowed before
    /// the verification is locked. Valid values range from 1 through 5. Omit this
    /// member to preserve the current value.
    max_attempts: ?i32 = null,

    /// The updated length of time, in minutes, that the one-time passcode remains
    /// valid. Valid values range from 1 through 60. Omit this member to preserve
    /// the current value.
    validity_period_minutes: ?i32 = null,

    pub const json_field_names = .{
        .code_length = "codeLength",
        .code_type = "codeType",
        .max_attempts = "maxAttempts",
        .validity_period_minutes = "validityPeriodMinutes",
    };
};
