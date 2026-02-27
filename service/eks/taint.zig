const TaintEffect = @import("taint_effect.zig").TaintEffect;

/// A property that allows a node to repel a `Pod`. For more information, see
/// [Node taints on
/// managed node
/// groups](https://docs.aws.amazon.com/eks/latest/userguide/node-taints-managed-node-groups.html) in the *Amazon EKS User Guide*.
pub const Taint = struct {
    /// The effect of the taint.
    effect: ?TaintEffect,

    /// The key of the taint.
    key: ?[]const u8,

    /// The value of the taint.
    value: ?[]const u8,

    pub const json_field_names = .{
        .effect = "effect",
        .key = "key",
        .value = "value",
    };
};
