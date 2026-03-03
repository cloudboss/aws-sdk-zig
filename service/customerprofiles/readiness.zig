/// Information indicating if the Calculated Attribute is ready for use by
/// confirming all
/// historical data has been processed and reflected.
pub const Readiness = struct {
    /// Any customer messaging.
    message: ?[]const u8 = null,

    /// Approximately how far the Calculated Attribute creation is from completion.
    progress_percentage: ?i32 = null,

    pub const json_field_names = .{
        .message = "Message",
        .progress_percentage = "ProgressPercentage",
    };
};
