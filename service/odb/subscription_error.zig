/// Information about an error that occurred during the subscription process.
pub const SubscriptionError = struct {
    /// A human-readable message that describes the subscription error.
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_message = "errorMessage",
    };
};
