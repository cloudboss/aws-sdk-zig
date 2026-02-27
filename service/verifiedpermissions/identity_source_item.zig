const ConfigurationItem = @import("configuration_item.zig").ConfigurationItem;
const IdentitySourceItemDetails = @import("identity_source_item_details.zig").IdentitySourceItemDetails;

/// A structure that defines an identity source.
///
/// This data type is a response parameter to the
/// [ListIdentitySources](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ListIdentitySources.html) operation.
pub const IdentitySourceItem = struct {
    /// Contains configuration information about an identity source.
    configuration: ?ConfigurationItem,

    /// The date and time the identity source was originally created.
    created_date: i64,

    /// A structure that contains the details of the associated identity provider
    /// (IdP).
    details: ?IdentitySourceItemDetails,

    /// The unique identifier of the identity source.
    identity_source_id: []const u8,

    /// The date and time the identity source was most recently updated.
    last_updated_date: i64,

    /// The identifier of the policy store that contains the identity source.
    policy_store_id: []const u8,

    /// The Cedar entity type of the principals returned from the IdP associated
    /// with this identity source.
    principal_entity_type: []const u8,

    pub const json_field_names = .{
        .configuration = "configuration",
        .created_date = "createdDate",
        .details = "details",
        .identity_source_id = "identitySourceId",
        .last_updated_date = "lastUpdatedDate",
        .policy_store_id = "policyStoreId",
        .principal_entity_type = "principalEntityType",
    };
};
