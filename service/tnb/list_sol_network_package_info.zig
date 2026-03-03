const ListSolNetworkPackageMetadata = @import("list_sol_network_package_metadata.zig").ListSolNetworkPackageMetadata;
const NsdOnboardingState = @import("nsd_onboarding_state.zig").NsdOnboardingState;
const NsdOperationalState = @import("nsd_operational_state.zig").NsdOperationalState;
const NsdUsageState = @import("nsd_usage_state.zig").NsdUsageState;

/// Details of a network package.
///
/// A network package is a .zip file in CSAR (Cloud Service Archive) format
/// defines the function packages you want to deploy and the Amazon Web Services
/// infrastructure you want to deploy them on.
pub const ListSolNetworkPackageInfo = struct {
    /// Network package ARN.
    arn: []const u8,

    /// ID of the individual network package.
    id: []const u8,

    /// The metadata of the network package.
    metadata: ListSolNetworkPackageMetadata,

    /// Designer of the onboarded network service descriptor in the network package.
    nsd_designer: ?[]const u8 = null,

    /// ID of the network service descriptor on which the network package is based.
    nsd_id: ?[]const u8 = null,

    /// Identifies a network service descriptor in a version independent manner.
    nsd_invariant_id: ?[]const u8 = null,

    /// Name of the onboarded network service descriptor in the network package.
    nsd_name: ?[]const u8 = null,

    /// Onboarding state of the network service descriptor in the network package.
    nsd_onboarding_state: NsdOnboardingState,

    /// Operational state of the network service descriptor in the network package.
    nsd_operational_state: NsdOperationalState,

    /// Usage state of the network service descriptor in the network package.
    nsd_usage_state: NsdUsageState,

    /// Version of the onboarded network service descriptor in the network package.
    nsd_version: ?[]const u8 = null,

    /// Identifies the function package for the function package descriptor
    /// referenced by the
    /// onboarded network package.
    vnf_pkg_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .metadata = "metadata",
        .nsd_designer = "nsdDesigner",
        .nsd_id = "nsdId",
        .nsd_invariant_id = "nsdInvariantId",
        .nsd_name = "nsdName",
        .nsd_onboarding_state = "nsdOnboardingState",
        .nsd_operational_state = "nsdOperationalState",
        .nsd_usage_state = "nsdUsageState",
        .nsd_version = "nsdVersion",
        .vnf_pkg_ids = "vnfPkgIds",
    };
};
