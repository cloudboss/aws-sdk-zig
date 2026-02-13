const Patch = @import("patch.zig").Patch;
const PatchStatus = @import("patch_status.zig").PatchStatus;

/// The `EffectivePatch` structure defines metadata about a patch along with the
/// approval state of the patch in a particular patch baseline. The approval
/// state includes
/// information about whether the patch is currently approved, due to be
/// approved by a rule,
/// explicitly approved, or explicitly rejected and the date the patch was or
/// will be
/// approved.
pub const EffectivePatch = struct {
    /// Provides metadata for a patch, including information such as the KB ID,
    /// severity,
    /// classification and a URL for where more information can be obtained about
    /// the patch.
    patch: ?Patch,

    /// The status of the patch in a patch baseline. This includes information about
    /// whether the
    /// patch is currently approved, due to be approved by a rule, explicitly
    /// approved, or explicitly
    /// rejected and the date the patch was or will be approved.
    patch_status: ?PatchStatus,

    pub const json_field_names = .{
        .patch = "Patch",
        .patch_status = "PatchStatus",
    };
};
