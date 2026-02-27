/// Usage information for the identity
/// pool.
pub const IdentityPoolUsage = struct {
    /// Data storage information for the identity
    /// pool.
    data_storage: ?i64,

    /// A name-spaced GUID (for example,
    /// us-east-1:23EC4050-6AEA-7089-A2DD-08002EXAMPLE) created by Amazon Cognito.
    /// GUID generation is
    /// unique within a region.
    identity_pool_id: ?[]const u8,

    /// Date on which the identity pool was
    /// last modified.
    last_modified_date: ?i64,

    /// Number of sync sessions for the
    /// identity pool.
    sync_sessions_count: ?i64,

    pub const json_field_names = .{
        .data_storage = "DataStorage",
        .identity_pool_id = "IdentityPoolId",
        .last_modified_date = "LastModifiedDate",
        .sync_sessions_count = "SyncSessionsCount",
    };
};
