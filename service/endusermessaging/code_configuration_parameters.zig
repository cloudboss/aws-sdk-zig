const CodeType = @import("code_type.zig").CodeType;

/// The passcode policy parameters that are grouped for reuse across a notify
/// code configuration and its create request. Each member is optional. When you
/// omit a member on a create request, no value is applied at create time and
/// the default is applied when a passcode is sent.
pub const CodeConfigurationParameters = struct {
    /// The number of characters in the one-time passcode. Valid values range from 4
    /// through 8. When you do not specify a value, the default is applied when a
    /// passcode is sent.
    code_length: ?i32 = null,

    /// The character set used to generate the one-time passcode. Valid values are
    /// NUMERIC (digits only), ALPHA (uppercase letters only), and ALPHANUMERIC
    /// (uppercase letters and digits). When you do not specify a value, the default
    /// is applied when a passcode is sent.
    code_type: ?CodeType = null,

    /// The maximum number of validation attempts that are allowed before the
    /// verification is locked. Valid values range from 1 through 5. When you do not
    /// specify a value, the default is applied when a passcode is sent.
    max_attempts: ?i32 = null,

    /// The length of time, in minutes, that the one-time passcode remains valid.
    /// Valid values range from 1 through 60. When you do not specify a value, the
    /// default is applied when a passcode is sent.
    validity_period_minutes: ?i32 = null,

    pub const json_field_names = .{
        .code_length = "codeLength",
        .code_type = "codeType",
        .max_attempts = "maxAttempts",
        .validity_period_minutes = "validityPeriodMinutes",
    };
};
