/// The schedule configuration for automatic patching.
pub const ClusterPatchSchedule = struct {
    /// The date and time of the next scheduled automatic patch. The system sets
    /// this automatically when a patch is detected. Use this field to reschedule
    /// the patch to a different date.
    next_patch_date: ?i64 = null,

    pub const json_field_names = .{
        .next_patch_date = "NextPatchDate",
    };
};
