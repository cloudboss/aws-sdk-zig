const aws = @import("aws");

/// Summary information about a provisioning artifact (also known as a version)
/// for a product.
pub const ProvisioningArtifactSummary = struct {
    /// The UTC time stamp of the creation time.
    created_time: ?i64,

    /// The description of the provisioning artifact.
    description: ?[]const u8,

    /// The identifier of the provisioning artifact.
    id: ?[]const u8,

    /// The name of the provisioning artifact.
    name: ?[]const u8,

    /// The metadata for the provisioning artifact. This is used with Amazon Web
    /// Services Marketplace products.
    provisioning_artifact_metadata: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .provisioning_artifact_metadata = "ProvisioningArtifactMetadata",
    };
};
