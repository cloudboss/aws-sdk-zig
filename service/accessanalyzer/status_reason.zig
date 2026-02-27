const ReasonCode = @import("reason_code.zig").ReasonCode;

/// Provides more details about the current status of the analyzer. For example,
/// if the creation for the analyzer fails, a `Failed` status is returned. For
/// an analyzer with organization as the type, this failure can be due to an
/// issue with creating the service-linked roles required in the member accounts
/// of the Amazon Web Services organization.
pub const StatusReason = struct {
    /// The reason code for the current status of the analyzer.
    code: ReasonCode,

    pub const json_field_names = .{
        .code = "code",
    };
};
