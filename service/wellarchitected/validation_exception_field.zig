/// Stores information about a field passed inside a request that resulted in an
/// exception.
pub const ValidationExceptionField = struct {
    message: []const u8,

    name: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .name = "Name",
    };
};
