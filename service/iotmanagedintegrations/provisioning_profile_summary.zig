const ProvisioningType = @import("provisioning_type.zig").ProvisioningType;
const ProvisioningProfileStatus = @import("provisioning_profile_status.zig").ProvisioningProfileStatus;

/// Structure describing a provisioning profile.
pub const ProvisioningProfileSummary = struct {
    /// The Amazon Resource Name (ARN) of the provisioning profile.
    arn: ?[]const u8 = null,

    /// The identifier of the provisioning profile.
    id: ?[]const u8 = null,

    /// The name of the provisioning profile.
    name: ?[]const u8 = null,

    /// The type of provisioning workflow the device uses for onboarding to IoT
    /// managed integrations.
    provisioning_type: ?ProvisioningType = null,

    /// The status of a provisioning profile.
    status: ?ProvisioningProfileStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .name = "Name",
        .provisioning_type = "ProvisioningType",
        .status = "Status",
    };
};
