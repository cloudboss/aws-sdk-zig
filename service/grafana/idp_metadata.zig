/// A structure containing the identity provider (IdP) metadata used to
/// integrate the identity provider with this workspace. You can specify the
/// metadata either by providing a URL to its location in the `url` parameter,
/// or by specifying the full metadata in XML format in the `xml` parameter.
/// Specifying both will cause an error.
pub const IdpMetadata = union(enum) {
    /// The URL of the location containing the IdP metadata.
    url: ?[]const u8,
    /// The full IdP metadata, in XML format.
    xml: ?[]const u8,

    pub const json_field_names = .{
        .url = "url",
        .xml = "xml",
    };
};
