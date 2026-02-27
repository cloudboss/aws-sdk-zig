/// Lifecycle last Cutover reverted.
pub const LifeCycleLastCutoverReverted = struct {
    /// Lifecycle last Cutover reverted API call date time.
    api_call_date_time: ?[]const u8,

    pub const json_field_names = .{
        .api_call_date_time = "apiCallDateTime",
    };
};
