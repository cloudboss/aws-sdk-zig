/// The error code and description resulting from an operation.
pub const RecordError = struct {
    /// The numeric value of the error.
    code: ?[]const u8 = null,

    /// The description of the error.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .description = "Description",
    };
};
