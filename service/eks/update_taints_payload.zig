const Taint = @import("taint.zig").Taint;

/// An object representing the details of an update to a taints payload. For
/// more
/// information, see [Node taints on
/// managed node
/// groups](https://docs.aws.amazon.com/eks/latest/userguide/node-taints-managed-node-groups.html) in the *Amazon EKS User Guide*.
pub const UpdateTaintsPayload = struct {
    /// Kubernetes taints to be added or updated.
    add_or_update_taints: ?[]const Taint,

    /// Kubernetes taints to remove.
    remove_taints: ?[]const Taint,

    pub const json_field_names = .{
        .add_or_update_taints = "addOrUpdateTaints",
        .remove_taints = "removeTaints",
    };
};
