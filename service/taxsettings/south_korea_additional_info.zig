/// Additional tax information associated with your TRN in South Korea.
pub const SouthKoreaAdditionalInfo = struct {
    /// The business legal name based on the most recently uploaded tax registration
    /// certificate.
    business_representative_name: []const u8,

    /// Item of business based on the most recently uploaded tax registration
    /// certificate.
    item_of_business: []const u8,

    /// Line of business based on the most recently uploaded tax registration
    /// certificate.
    line_of_business: []const u8,

    pub const json_field_names = .{
        .business_representative_name = "businessRepresentativeName",
        .item_of_business = "itemOfBusiness",
        .line_of_business = "lineOfBusiness",
    };
};
