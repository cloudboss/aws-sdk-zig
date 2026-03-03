/// Additional tax information to specify for a TRN in Egypt.
pub const EgyptAdditionalInfo = struct {
    /// The unique identification number provided by the Egypt Tax Authority.
    unique_identification_number: ?[]const u8 = null,

    /// The expiration date of the unique identification number provided by the
    /// Egypt Tax Authority.
    unique_identification_number_expiration_date: ?[]const u8 = null,

    pub const json_field_names = .{
        .unique_identification_number = "uniqueIdentificationNumber",
        .unique_identification_number_expiration_date = "uniqueIdentificationNumberExpirationDate",
    };
};
