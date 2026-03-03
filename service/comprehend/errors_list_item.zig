const PageBasedErrorCode = @import("page_based_error_code.zig").PageBasedErrorCode;

/// Text extraction encountered one or more page-level errors in the input
/// document.
///
/// The `ErrorCode` contains one of the following values:
///
/// * TEXTRACT_BAD_PAGE - Amazon Textract cannot read the page. For more
///   information
/// about page limits in Amazon Textract, see [
/// Page Quotas in Amazon
/// Textract](https://docs.aws.amazon.com/textract/latest/dg/limits-document.html).
///
/// * TEXTRACT_PROVISIONED_THROUGHPUT_EXCEEDED - The number of requests exceeded
///   your throughput limit.
/// For more information about throughput quotas in Amazon Textract, see [
/// Default quotas in Amazon
/// Textract](https://docs.aws.amazon.com/textract/latest/dg/limits-quotas-explained.html).
///
/// * PAGE_CHARACTERS_EXCEEDED - Too many text characters on the page (10,000
///   characters maximum).
///
/// * PAGE_SIZE_EXCEEDED - The maximum page size is 10 MB.
///
/// * INTERNAL_SERVER_ERROR - The request encountered a service issue. Try the
///   API request again.
pub const ErrorsListItem = struct {
    /// Error code for the cause of the error.
    error_code: ?PageBasedErrorCode = null,

    /// Text message explaining the reason for the error.
    error_message: ?[]const u8 = null,

    /// Page number where the error occurred.
    page: ?i32 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .page = "Page",
    };
};
