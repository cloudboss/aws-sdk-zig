const ProvisioningArtifactGuidance = @import("provisioning_artifact_guidance.zig").ProvisioningArtifactGuidance;

/// Information about a provisioning artifact. A provisioning artifact is also
/// known as a product version.
pub const ProvisioningArtifact = struct {
    /// The UTC time stamp of the creation time.
    created_time: ?i64,

    /// The description of the provisioning artifact.
    description: ?[]const u8,

    /// Information set by the administrator to provide guidance to end users about
    /// which provisioning artifacts to use.
    guidance: ?ProvisioningArtifactGuidance,

    /// The identifier of the provisioning artifact.
    id: ?[]const u8,

    /// The name of the provisioning artifact.
    name: ?[]const u8,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .description = "Description",
        .guidance = "Guidance",
        .id = "Id",
        .name = "Name",
    };
};
