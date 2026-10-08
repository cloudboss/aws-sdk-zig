const StatementEffect = @import("statement_effect.zig").StatementEffect;

/// A statement that matched during evaluation.
pub const MatchedStatement = struct {
    /// The evaluated effect of this statement. Valid values:
    ///
    /// * `ALLOW` - The statement allows the action.
    /// * `DENY` - The statement denies the action.
    evaluated_effect: ?StatementEffect = null,

    /// The statement ID (Sid). If the statement has no Sid, one is generated for
    /// reference.
    sid: ?[]const u8 = null,

    pub const json_field_names = .{
        .evaluated_effect = "evaluatedEffect",
        .sid = "sid",
    };
};
