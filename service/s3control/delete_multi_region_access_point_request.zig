const DeleteMultiRegionAccessPointInput = @import("delete_multi_region_access_point_input.zig").DeleteMultiRegionAccessPointInput;

pub const DeleteMultiRegionAccessPointRequest = struct {
    /// The Amazon Web Services account ID for the owner of the Multi-Region Access
    /// Point.
    account_id: []const u8,

    /// An idempotency token used to identify the request and guarantee that
    /// requests are
    /// unique.
    client_token: []const u8,

    /// A container element containing details about the Multi-Region Access Point.
    details: DeleteMultiRegionAccessPointInput,
};
