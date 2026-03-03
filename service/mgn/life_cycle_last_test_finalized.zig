/// Lifecycle last Test finalized.
pub const LifeCycleLastTestFinalized = struct {
    /// Lifecycle Test failed API call date and time.
    api_call_date_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_call_date_time = "apiCallDateTime",
    };
};
