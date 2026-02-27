/// Provides a standard to identify security findings using OCSF.
pub const OcsfFindingIdentifier = struct {
    /// Finding cloud.account.uid, which is a unique identifier in the Amazon Web
    /// Services account..
    cloud_account_uid: []const u8,

    /// Finding finding_info.uid, which is a unique identifier for the finding from
    /// the finding provider.
    finding_info_uid: []const u8,

    /// Finding metadata.product.uid, which is a unique identifier for the product.
    metadata_product_uid: []const u8,

    pub const json_field_names = .{
        .cloud_account_uid = "CloudAccountUid",
        .finding_info_uid = "FindingInfoUid",
        .metadata_product_uid = "MetadataProductUid",
    };
};
