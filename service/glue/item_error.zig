/// An error that occurred when retrieving an iterable form item.
pub const ItemError = struct {
    /// The error code.
    code: ?[]const u8 = null,

    /// The identifier of the item that caused the error.
    item_identifier: ?[]const u8 = null,

    /// The error message.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .item_identifier = "ItemIdentifier",
        .message = "Message",
    };
};
