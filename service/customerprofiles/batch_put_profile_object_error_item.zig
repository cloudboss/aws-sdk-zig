/// An item that failed to be added to the domain.
pub const BatchPutProfileObjectErrorItem = struct {
    /// The HTTP status code for the error.
    code: i32,

    /// The unique identifier of the item in the batch request that failed.
    id: []const u8,

    /// A message describing the error.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .id = "Id",
        .message = "Message",
    };
};
