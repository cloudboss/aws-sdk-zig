/// Additional tax information associated with your TRN in Brazil.
pub const BrazilAdditionalInfo = struct {
    /// The Cadastro de Contribuintes Mobiliários (CCM) code for your TRN in Brazil.
    /// This only applies for a CNPJ tax type for the São Paulo municipality.
    ccm_code: ?[]const u8 = null,

    /// Legal nature of business, based on your TRN in Brazil. This only applies for
    /// a CNPJ tax
    /// type.
    legal_nature_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .ccm_code = "ccmCode",
        .legal_nature_code = "legalNatureCode",
    };
};
