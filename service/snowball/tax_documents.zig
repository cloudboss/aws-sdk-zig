const INDTaxDocuments = @import("ind_tax_documents.zig").INDTaxDocuments;

/// The tax documents required in your Amazon Web Services Region.
pub const TaxDocuments = struct {
    ind: ?INDTaxDocuments = null,

    pub const json_field_names = .{
        .ind = "IND",
    };
};
