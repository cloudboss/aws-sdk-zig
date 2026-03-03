/// A structure that defines characteristics of an identity source that you can
/// use to filter.
///
/// This data type is a request parameter for the
/// [ListIdentityStores](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ListIdentityStores.html) operation.
pub const IdentitySourceFilter = struct {
    /// The Cedar entity type of the principals returned by the identity provider
    /// (IdP) associated with this identity source.
    principal_entity_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .principal_entity_type = "principalEntityType",
    };
};
