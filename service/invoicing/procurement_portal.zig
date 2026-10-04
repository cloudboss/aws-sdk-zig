const FeatureConfigurations = @import("feature_configurations.zig").FeatureConfigurations;
const ProcurementPortalName = @import("procurement_portal_name.zig").ProcurementPortalName;

/// Contains metadata for a procurement portal, including the portal identifier,
/// name, and default feature configurations.
pub const ProcurementPortal = struct {
    /// The default feature configurations for the procurement portal.
    default_feature_configurations: ?FeatureConfigurations = null,

    /// The display name of the procurement portal.
    portal_display_name: ?[]const u8 = null,

    /// The unique identifier of the procurement portal.
    portal_identifier: []const u8,

    /// The name of the procurement portal.
    portal_name: ProcurementPortalName,

    pub const json_field_names = .{
        .default_feature_configurations = "DefaultFeatureConfigurations",
        .portal_display_name = "PortalDisplayName",
        .portal_identifier = "PortalIdentifier",
        .portal_name = "PortalName",
    };
};
