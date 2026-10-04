/// A structure that contains the identifiers for an identity store: its
/// globally unique identifier (ID) and Amazon Resource Name (ARN).
pub const IdentityStore = struct {
    /// The Amazon Resource Name (ARN) of the identity store. For example,
    /// `arn:aws:identitystore::111122223333:identitystore/d-1234567890`.
    identity_store_arn: []const u8,

    /// The globally unique identifier for the identity store.
    identity_store_id: []const u8,

    pub const json_field_names = .{
        .identity_store_arn = "IdentityStoreArn",
        .identity_store_id = "IdentityStoreId",
    };
};
