const std = @import("std");

pub const UpdateType = enum {
    version_update,
    endpoint_access_update,
    logging_update,
    config_update,
    associate_identity_provider_config,
    disassociate_identity_provider_config,
    associate_encryption_config,
    addon_update,
    vpc_config_update,
    access_config_update,
    upgrade_policy_update,
    zonal_shift_config_update,
    auto_mode_update,
    remote_network_config_update,
    deletion_protection_update,
    control_plane_scaling_config_update,

    pub const json_field_names = .{
        .version_update = "VersionUpdate",
        .endpoint_access_update = "EndpointAccessUpdate",
        .logging_update = "LoggingUpdate",
        .config_update = "ConfigUpdate",
        .associate_identity_provider_config = "AssociateIdentityProviderConfig",
        .disassociate_identity_provider_config = "DisassociateIdentityProviderConfig",
        .associate_encryption_config = "AssociateEncryptionConfig",
        .addon_update = "AddonUpdate",
        .vpc_config_update = "VpcConfigUpdate",
        .access_config_update = "AccessConfigUpdate",
        .upgrade_policy_update = "UpgradePolicyUpdate",
        .zonal_shift_config_update = "ZonalShiftConfigUpdate",
        .auto_mode_update = "AutoModeUpdate",
        .remote_network_config_update = "RemoteNetworkConfigUpdate",
        .deletion_protection_update = "DeletionProtectionUpdate",
        .control_plane_scaling_config_update = "ControlPlaneScalingConfigUpdate",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .version_update => "VersionUpdate",
            .endpoint_access_update => "EndpointAccessUpdate",
            .logging_update => "LoggingUpdate",
            .config_update => "ConfigUpdate",
            .associate_identity_provider_config => "AssociateIdentityProviderConfig",
            .disassociate_identity_provider_config => "DisassociateIdentityProviderConfig",
            .associate_encryption_config => "AssociateEncryptionConfig",
            .addon_update => "AddonUpdate",
            .vpc_config_update => "VpcConfigUpdate",
            .access_config_update => "AccessConfigUpdate",
            .upgrade_policy_update => "UpgradePolicyUpdate",
            .zonal_shift_config_update => "ZonalShiftConfigUpdate",
            .auto_mode_update => "AutoModeUpdate",
            .remote_network_config_update => "RemoteNetworkConfigUpdate",
            .deletion_protection_update => "DeletionProtectionUpdate",
            .control_plane_scaling_config_update => "ControlPlaneScalingConfigUpdate",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
