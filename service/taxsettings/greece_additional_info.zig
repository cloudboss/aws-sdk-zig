/// Additional tax information to specify for a TRN in Greece.
pub const GreeceAdditionalInfo = struct {
    /// The code of contracting authority for e-invoicing.
    contracting_authority_code: ?[]const u8,

    pub const json_field_names = .{
        .contracting_authority_code = "contractingAuthorityCode",
    };
};
