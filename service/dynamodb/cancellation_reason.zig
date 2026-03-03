const aws = @import("aws");

const AttributeValue = @import("attribute_value.zig").AttributeValue;

/// An ordered list of errors for each item in the request which caused the
/// transaction to
/// get cancelled. The values of the list are ordered according to the ordering
/// of the
/// `TransactWriteItems` request parameter. If no error occurred for the
/// associated item an error with a Null code and Null message will be present.
pub const CancellationReason = struct {
    /// Status code for the result of the cancelled transaction.
    code: ?[]const u8 = null,

    /// Item in the request which caused the transaction to get cancelled.
    item: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// Cancellation reason message description.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .item = "Item",
        .message = "Message",
    };
};
