/// Match score for a secondary address component in the result.
pub const SecondaryAddressComponentMatchScore = struct {
    /// Match score for the secondary address number.
    number: f64 = 0,

    pub const json_field_names = .{
        .number = "Number",
    };
};
