const InvoiceConfiguration = @import("invoice_configuration.zig").InvoiceConfiguration;

/// Contains the default feature configuration settings for a procurement
/// portal.
pub const FeatureConfigurations = struct {
    /// The invoice configuration settings for the procurement portal.
    invoice_configuration: ?InvoiceConfiguration = null,

    pub const json_field_names = .{
        .invoice_configuration = "InvoiceConfiguration",
    };
};
