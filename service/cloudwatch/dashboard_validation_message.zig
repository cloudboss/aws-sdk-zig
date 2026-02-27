/// An error or warning for the operation.
pub const DashboardValidationMessage = struct {
    /// The data path related to the message.
    data_path: ?[]const u8,

    /// A message describing the error or warning.
    message: ?[]const u8,

    pub const json_field_names = .{
        .data_path = "DataPath",
        .message = "Message",
    };
};
