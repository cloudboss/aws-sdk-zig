const IndonesiaTaxRegistrationNumberType = @import("indonesia_tax_registration_number_type.zig").IndonesiaTaxRegistrationNumberType;

/// Additional tax information associated with your TRN in Indonesia.
pub const IndonesiaAdditionalInfo = struct {
    /// VAT-exempt customers have a Directorate General of Taxation (DGT) exemption
    /// letter or certificate (Surat Keterangan Bebas) decision number.
    /// Non-collected VAT have a DGT letter or certificate (Surat Keterangan Tidak
    /// Dipungut).
    decision_number: ?[]const u8,

    /// Exception code if you are designated by Directorate General of Taxation
    /// (DGT) as a VAT collector, non-collected VAT, or VAT-exempt customer.
    ppn_exception_designation_code: ?[]const u8,

    /// The tax registration number type.
    tax_registration_number_type: ?IndonesiaTaxRegistrationNumberType,

    pub const json_field_names = .{
        .decision_number = "decisionNumber",
        .ppn_exception_designation_code = "ppnExceptionDesignationCode",
        .tax_registration_number_type = "taxRegistrationNumberType",
    };
};
