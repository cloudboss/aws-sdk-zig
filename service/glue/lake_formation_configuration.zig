/// Specifies Lake Formation configuration settings for the crawler.
pub const LakeFormationConfiguration = struct {
    /// Required for cross account crawls. For same account crawls as the target
    /// data, this can be left as null.
    account_id: ?[]const u8 = null,

    /// Specifies whether to use Lake Formation credentials for the crawler instead
    /// of the IAM role credentials.
    use_lake_formation_credentials: ?bool = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .use_lake_formation_credentials = "UseLakeFormationCredentials",
    };
};
