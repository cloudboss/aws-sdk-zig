/// Additional tax information associated with your TRN in Monaco.
pub const MonacoAdditionalInfo = struct {
    /// The business number for the company in Monaco. Can be up to 12 alphanumeric
    /// characters.
    business_number: []const u8,

    pub const json_field_names = .{
        .business_number = "businessNumber",
    };
};
