const FailedItemErrorCode = @import("failed_item_error_code.zig").FailedItemErrorCode;

/// Includes details about the failed items.
pub const FailedItemDetails = struct {
    /// The status code of a failed item.
    failure_code: FailedItemErrorCode,

    /// Indicates whether you can immediately retry a request for this item for a
    /// specified
    /// resource.
    retryable: bool,

    pub const json_field_names = .{
        .failure_code = "failureCode",
        .retryable = "retryable",
    };
};
