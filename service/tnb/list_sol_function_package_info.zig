const ListSolFunctionPackageMetadata = @import("list_sol_function_package_metadata.zig").ListSolFunctionPackageMetadata;
const OnboardingState = @import("onboarding_state.zig").OnboardingState;
const OperationalState = @import("operational_state.zig").OperationalState;
const UsageState = @import("usage_state.zig").UsageState;

/// Information about a function package.
///
/// A function package is a .zip file in CSAR (Cloud Service Archive) format
/// that contains a network function (an ETSI standard telecommunication
/// application) and function package descriptor that uses the TOSCA standard to
/// describe how the network functions should run on your network.
pub const ListSolFunctionPackageInfo = struct {
    /// Function package ARN.
    arn: []const u8,

    /// ID of the function package.
    id: []const u8,

    /// The metadata of the function package.
    metadata: ?ListSolFunctionPackageMetadata = null,

    /// Onboarding state of the function package.
    onboarding_state: OnboardingState,

    /// Operational state of the function package.
    operational_state: OperationalState,

    /// Usage state of the function package.
    usage_state: UsageState,

    /// Identifies the function package and the function package descriptor.
    vnfd_id: ?[]const u8 = null,

    /// Identifies the version of the function package descriptor.
    vnfd_version: ?[]const u8 = null,

    /// The product name for the network function.
    vnf_product_name: ?[]const u8 = null,

    /// Provider of the function package and the function package descriptor.
    vnf_provider: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .metadata = "metadata",
        .onboarding_state = "onboardingState",
        .operational_state = "operationalState",
        .usage_state = "usageState",
        .vnfd_id = "vnfdId",
        .vnfd_version = "vnfdVersion",
        .vnf_product_name = "vnfProductName",
        .vnf_provider = "vnfProvider",
    };
};
