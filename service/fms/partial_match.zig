/// The reference rule that partially matches the `ViolationTarget` rule and
/// violation reason.
pub const PartialMatch = struct {
    /// The reference rule from the primary security group of the Firewall Manager
    /// policy.
    reference: ?[]const u8,

    /// The violation reason.
    target_violation_reasons: ?[]const []const u8,

    pub const json_field_names = .{
        .reference = "Reference",
        .target_violation_reasons = "TargetViolationReasons",
    };
};
