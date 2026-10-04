const AzureDetail = @import("azure_detail.zig").AzureDetail;

/// The detailed cloud provider configuration for a connector. This is a union
/// type that currently supports Azure.
pub const CspmProviderDetail = union(enum) {
    /// The Azure provider detail.
    azure: ?AzureDetail,

    pub const json_field_names = .{
        .azure = "Azure",
    };
};
