const CheckResult = @import("check_result.zig").CheckResult;
const CheckType = @import("check_type.zig").CheckType;

/// A check on a connector to identify connectivity health.
pub const ConnectorCheck = struct {
    /// The time when connector health began to be impaired.
    impaired_since: ?i64 = null,

    /// The date and time of the last check attempt.
    last_check_attempt: ?i64 = null,

    /// The check result.
    result: ?CheckResult = null,

    /// The check type.
    @"type": ?CheckType = null,

    pub const json_field_names = .{
        .impaired_since = "impairedSince",
        .last_check_attempt = "lastCheckAttempt",
        .result = "result",
        .@"type" = "type",
    };
};
