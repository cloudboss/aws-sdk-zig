const DataSourceErrorInfoType = @import("data_source_error_info_type.zig").DataSourceErrorInfoType;

/// Error information for the data source creation or update.
pub const DataSourceErrorInfo = struct {
    /// Error message.
    message: ?[]const u8 = null,

    /// Error type.
    @"type": ?DataSourceErrorInfoType = null,

    pub const json_field_names = .{
        .message = "Message",
        .@"type" = "Type",
    };
};
