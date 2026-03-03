const ProvisioningType = @import("provisioning_type.zig").ProvisioningType;

/// Structure describing a provisioning profile.
pub const ProvisioningProfileSummary = struct {
    /// The Amazon Resource Name (ARN) of the provisioning template used in the
    /// provisioning profile.
    arn: ?[]const u8 = null,

    /// The identifier of the provisioning profile.
    id: ?[]const u8 = null,

    /// The name of the provisioning template.
    name: ?[]const u8 = null,

    /// The type of provisioning workflow the device uses for onboarding to IoT
    /// managed integrations.
    provisioning_type: ?ProvisioningType = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .name = "Name",
        .provisioning_type = "ProvisioningType",
    };
};
