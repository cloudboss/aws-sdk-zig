const MicrosoftPurviewProviderConfig = @import("microsoft_purview_provider_config.zig").MicrosoftPurviewProviderConfig;

/// The provider-specific configuration for a DLP integration. This is a union
/// type structure. For this structure to be valid, only one of the attributes
/// can be defined.
pub const ProviderConfig = union(enum) {
    /// The configuration for a Microsoft Purview DLP integration.
    microsoft_purview: ?MicrosoftPurviewProviderConfig,

    pub const json_field_names = .{
        .microsoft_purview = "MicrosoftPurview",
    };
};
