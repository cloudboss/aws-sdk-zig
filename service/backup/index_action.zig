/// This is an optional array within a BackupRule.
///
/// IndexAction consists of one ResourceTypes.
pub const IndexAction = struct {
    /// 0 or 1 index action will be accepted for each BackupRule.
    ///
    /// Valid values:
    ///
    /// * `EBS` for Amazon Elastic Block Store
    ///
    /// * `S3` for Amazon Simple Storage Service (Amazon S3)
    resource_types: ?[]const []const u8,

    pub const json_field_names = .{
        .resource_types = "ResourceTypes",
    };
};
