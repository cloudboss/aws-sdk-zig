const ErrorCode = @import("error_code.zig").ErrorCode;

/// The unique failed custom vocabulary item from the custom
/// vocabulary list.
pub const FailedCustomVocabularyItem = struct {
    /// The unique error code for the failed custom vocabulary item
    /// from the custom vocabulary list.
    error_code: ?ErrorCode = null,

    /// The error message for the failed custom vocabulary item
    /// from the custom vocabulary list.
    error_message: ?[]const u8 = null,

    /// The unique item identifer for the failed custom vocabulary item
    /// from the custom vocabulary list.
    item_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .item_id = "itemId",
    };
};
