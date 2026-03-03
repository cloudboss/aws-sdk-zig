/// The tax documents required in Amazon Web Services Region in India.
pub const INDTaxDocuments = struct {
    /// The Goods and Services Tax (GST) documents required in Amazon Web Services
    /// Region in
    /// India.
    gstin: ?[]const u8 = null,

    pub const json_field_names = .{
        .gstin = "GSTIN",
    };
};
