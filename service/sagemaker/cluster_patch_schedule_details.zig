/// The schedule details for automatic patching, including the next scheduled
/// patch date.
pub const ClusterPatchScheduleDetails = struct {
    /// The date and time of the next scheduled automatic patch.
    next_patch_date: ?i64 = null,

    pub const json_field_names = .{
        .next_patch_date = "NextPatchDate",
    };
};
