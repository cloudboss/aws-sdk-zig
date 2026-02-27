/// Lifecycle last Test reverted.
pub const LifeCycleLastTestReverted = struct {
    /// Lifecycle last Test reverted API call date and time.
    api_call_date_time: ?[]const u8,

    pub const json_field_names = .{
        .api_call_date_time = "apiCallDateTime",
    };
};
