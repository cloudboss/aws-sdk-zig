/// Information about the resources a trust store is associated with.
pub const TrustStoreAssociation = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: ?[]const u8,
};
