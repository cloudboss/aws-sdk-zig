/// A data type pair that consists of a `KeyName` and `Values` list
/// that is used in conjunction with the
/// [KeyName](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_SearchProfiles.html#customerprofiles-SearchProfiles-request-KeyName) and [Values](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_SearchProfiles.html#customerprofiles-SearchProfiles-request-Values) parameters to search for profiles using the [SearchProfiles](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_SearchProfiles.html)
/// API.
pub const AdditionalSearchKey = struct {
    /// A searchable identifier of a customer profile.
    key_name: []const u8,

    /// A list of key values.
    values: []const []const u8,

    pub const json_field_names = .{
        .key_name = "KeyName",
        .values = "Values",
    };
};
