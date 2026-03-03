const RestEndpointIdentifier = @import("rest_endpoint_identifier.zig").RestEndpointIdentifier;
const Status = @import("status.zig").Status;
const StatusException = @import("status_exception.zig").StatusException;
const TryItState = @import("try_it_state.zig").TryItState;

/// A summary of a product REST endpoint page, without providing the page
/// content.
pub const ProductRestEndpointPageSummaryNoBody = struct {
    /// The endpoint of the product REST endpoint page.
    endpoint: []const u8,

    /// The timestamp when the product REST endpoint page was last modified.
    last_modified: i64,

    /// The operation name of the product REST endpoint.
    operation_name: ?[]const u8 = null,

    /// The ARN of the product REST endpoint page.
    product_rest_endpoint_page_arn: []const u8,

    /// The product REST endpoint page identifier.
    product_rest_endpoint_page_id: []const u8,

    /// The REST endpoint identifier.
    rest_endpoint_identifier: RestEndpointIdentifier,

    /// The status.
    status: Status,

    /// The status exception information.
    status_exception: ?StatusException = null,

    /// The try it state of a product REST endpoint page.
    try_it_state: TryItState,

    pub const json_field_names = .{
        .endpoint = "Endpoint",
        .last_modified = "LastModified",
        .operation_name = "OperationName",
        .product_rest_endpoint_page_arn = "ProductRestEndpointPageArn",
        .product_rest_endpoint_page_id = "ProductRestEndpointPageId",
        .rest_endpoint_identifier = "RestEndpointIdentifier",
        .status = "Status",
        .status_exception = "StatusException",
        .try_it_state = "TryItState",
    };
};
