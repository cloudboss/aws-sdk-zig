const ProductViewSummary = @import("product_view_summary.zig").ProductViewSummary;
const ProvisioningArtifact = @import("provisioning_artifact.zig").ProvisioningArtifact;

/// An object that contains summary information about a product view and a
/// provisioning artifact.
pub const ProvisioningArtifactView = struct {
    /// Summary information about a product view.
    product_view_summary: ?ProductViewSummary = null,

    /// Information about a provisioning artifact. A provisioning artifact is also
    /// known as a product version.
    provisioning_artifact: ?ProvisioningArtifact = null,

    pub const json_field_names = .{
        .product_view_summary = "ProductViewSummary",
        .provisioning_artifact = "ProvisioningArtifact",
    };
};
