/// A description of the identity pool.
pub const IdentityPoolShortDescription = struct {
    /// An identity pool ID in the format REGION:GUID.
    identity_pool_id: ?[]const u8 = null,

    /// A string that you provide.
    identity_pool_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .identity_pool_id = "IdentityPoolId",
        .identity_pool_name = "IdentityPoolName",
    };
};
