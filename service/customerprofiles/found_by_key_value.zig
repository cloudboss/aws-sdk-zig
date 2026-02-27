/// A data type pair that consists of a `KeyName` and `Values` list
/// that were used to find a profile returned in response to a
/// [SearchProfiles](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_SearchProfiles.html) request.
pub const FoundByKeyValue = struct {
    /// A searchable identifier of a customer profile.
    key_name: ?[]const u8,

    /// A list of key values.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .key_name = "KeyName",
        .values = "Values",
    };
};
