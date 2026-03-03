const PatchBaselineIdentity = @import("patch_baseline_identity.zig").PatchBaselineIdentity;

/// The mapping between a patch group and the patch baseline the patch group is
/// registered
/// with.
pub const PatchGroupPatchBaselineMapping = struct {
    /// The patch baseline the patch group is registered with.
    baseline_identity: ?PatchBaselineIdentity = null,

    /// The name of the patch group registered with the patch baseline.
    patch_group: ?[]const u8 = null,

    pub const json_field_names = .{
        .baseline_identity = "BaselineIdentity",
        .patch_group = "PatchGroup",
    };
};
