/// A configuration ID paired with a warning message.
pub const DeletionWarning = struct {
    /// The unique identifier of the configuration that produced a warning.
    configuration_id: ?[]const u8 = null,

    /// The integer warning code associated with the warning message.
    warning_code: i32 = 0,

    /// A descriptive message of the warning the associated configuration ID
    /// produced.
    warning_text: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_id = "configurationId",
        .warning_code = "warningCode",
        .warning_text = "warningText",
    };
};
