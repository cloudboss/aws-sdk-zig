const CreateMultiRegionAccessPointInput = @import("create_multi_region_access_point_input.zig").CreateMultiRegionAccessPointInput;

pub const CreateMultiRegionAccessPointRequest = struct {
    /// The Amazon Web Services account ID for the owner of the Multi-Region Access
    /// Point. The owner of the Multi-Region Access Point also must own
    /// the underlying buckets.
    account_id: []const u8,

    /// An idempotency token used to identify the request and guarantee that
    /// requests are
    /// unique.
    client_token: []const u8,

    /// A container element containing details about the Multi-Region Access Point.
    details: CreateMultiRegionAccessPointInput,
};
