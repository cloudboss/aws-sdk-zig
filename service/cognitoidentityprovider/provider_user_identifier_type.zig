/// The characteristics of a source or destination user for linking a federated
/// user
/// profile to a local user profile.
pub const ProviderUserIdentifierType = struct {
    /// The name of the provider attribute to link to, such as `NameID`.
    provider_attribute_name: ?[]const u8,

    /// The value of the provider attribute to link to, such as
    /// `xxxxx_account`.
    provider_attribute_value: ?[]const u8,

    /// The name of the provider, such as Facebook, Google, or Login with Amazon.
    provider_name: ?[]const u8,

    pub const json_field_names = .{
        .provider_attribute_name = "ProviderAttributeName",
        .provider_attribute_value = "ProviderAttributeValue",
        .provider_name = "ProviderName",
    };
};
