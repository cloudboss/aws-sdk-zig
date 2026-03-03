/// Lifecycle Cutover finalized
pub const LifeCycleLastCutoverFinalized = struct {
    /// Lifecycle Cutover finalized date and time.
    api_call_date_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_call_date_time = "apiCallDateTime",
    };
};
