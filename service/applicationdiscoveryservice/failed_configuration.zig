/// A configuration ID paired with an error message.
pub const FailedConfiguration = struct {
    /// The unique identifier of the configuration the failed to delete.
    configuration_id: ?[]const u8 = null,

    /// A descriptive message indicating why the associated configuration failed to
    /// delete.
    error_message: ?[]const u8 = null,

    /// The integer error code associated with the error message.
    error_status_code: i32 = 0,

    pub const json_field_names = .{
        .configuration_id = "configurationId",
        .error_message = "errorMessage",
        .error_status_code = "errorStatusCode",
    };
};
