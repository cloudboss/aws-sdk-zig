const OwnershipControlsRule = @import("ownership_controls_rule.zig").OwnershipControlsRule;

/// The container element for a bucket's ownership controls.
pub const OwnershipControls = struct {
    /// The container element for an ownership control rule.
    rules: []const OwnershipControlsRule,
};
