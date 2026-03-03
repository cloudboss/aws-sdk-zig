/// Contains details about a Map Run failure event that occurred during a state
/// machine execution.
pub const MapRunFailedEventDetails = struct {
    /// A more detailed explanation of the cause of the failure.
    cause: ?[]const u8 = null,

    /// The error code of the Map Run failure.
    @"error": ?[]const u8 = null,

    pub const json_field_names = .{
        .cause = "cause",
        .@"error" = "error",
    };
};
