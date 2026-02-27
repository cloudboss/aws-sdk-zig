const ProductViewSummary = @import("product_view_summary.zig").ProductViewSummary;
const SourceConnectionDetail = @import("source_connection_detail.zig").SourceConnectionDetail;
const Status = @import("status.zig").Status;

/// Information about a product view.
pub const ProductViewDetail = struct {
    /// The UTC time stamp of the creation time.
    created_time: ?i64,

    /// The ARN of the product.
    product_arn: ?[]const u8,

    /// Summary information about the product view.
    product_view_summary: ?ProductViewSummary,

    /// A top level `ProductViewDetail` response containing details about the
    /// product’s connection.
    /// Service Catalog returns this field for the `CreateProduct`, `UpdateProduct`,
    /// `DescribeProductAsAdmin`, and `SearchProductAsAdmin` APIs.
    /// This response contains the same fields as the `ConnectionParameters`
    /// request, with the
    /// addition of the `LastSync` response.
    source_connection: ?SourceConnectionDetail,

    /// The status of the product.
    ///
    /// * `AVAILABLE` - The product is ready for use.
    ///
    /// * `CREATING` - Product creation has started; the product is not ready for
    ///   use.
    ///
    /// * `FAILED` - An action failed.
    status: ?Status,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .product_arn = "ProductARN",
        .product_view_summary = "ProductViewSummary",
        .source_connection = "SourceConnection",
        .status = "Status",
    };
};
