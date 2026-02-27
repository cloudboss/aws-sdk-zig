/// Usage information for the identity.
pub const IdentityUsage = struct {
    /// Number of datasets for the
    /// identity.
    dataset_count: i32 = 0,

    /// Total data storage for this
    /// identity.
    data_storage: ?i64,

    /// A name-spaced GUID (for example,
    /// us-east-1:23EC4050-6AEA-7089-A2DD-08002EXAMPLE) created by Amazon Cognito.
    /// GUID generation is
    /// unique within a region.
    identity_id: ?[]const u8,

    /// A name-spaced GUID (for example,
    /// us-east-1:23EC4050-6AEA-7089-A2DD-08002EXAMPLE) created by Amazon Cognito.
    /// GUID generation is
    /// unique within a region.
    identity_pool_id: ?[]const u8,

    /// Date on which the identity was last
    /// modified.
    last_modified_date: ?i64,

    pub const json_field_names = .{
        .dataset_count = "DatasetCount",
        .data_storage = "DataStorage",
        .identity_id = "IdentityId",
        .identity_pool_id = "IdentityPoolId",
        .last_modified_date = "LastModifiedDate",
    };
};
