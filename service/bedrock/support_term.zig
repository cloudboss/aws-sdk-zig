/// Describes a support term.
pub const SupportTerm = struct {
    /// Describes the refund policy.
    refund_policy_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .refund_policy_description = "refundPolicyDescription",
    };
};
