const Bandwidths = @import("bandwidths.zig").Bandwidths;
const Provider = @import("provider.zig").Provider;
const RemoteAccountIdentifierType = @import("remote_account_identifier_type.zig").RemoteAccountIdentifierType;
const EnvironmentState = @import("environment_state.zig").EnvironmentState;

/// Defines the logical topology that an AWS Interconnect Connection is created
/// upon.
///
/// Specifically, an Environment defines the partner The remote Cloud Service
/// Provider of this resource. or The remote Last Mile Provider of this
/// resource. and the region or location specification to which an AWS
/// Interconnect Connection can be made.
pub const Environment = struct {
    /// An HTTPS URL on the remote partner portal where the Activation Key should be
    /// brought to complete the creation process.
    activation_page_url: ?[]const u8 = null,

    /// The sets of bandwidths that are available and supported on this environment.
    bandwidths: Bandwidths,

    /// The identifier of this Environment
    environment_id: []const u8,

    /// The provider specific location on the remote side of this Connection.
    location: []const u8,

    /// The provider on the remote side of this Connection.
    provider: Provider,

    /// The type of identifying information that should be supplied to the
    /// `remoteAccount` parameter of a CreateConnection call for this specific
    /// Environment.
    remote_identifier_type: ?RemoteAccountIdentifierType = null,

    /// The state of the Environment. Possible values:
    ///
    /// * `available`: The environment is available and new Connection objects can
    ///   be requested.
    /// * `limited`: The environment is available, but overall capacity is limited.
    ///   The set of available bandwidths
    /// * `unavailable`: The environment is currently unavailable.
    state: EnvironmentState,

    /// The specific product type of Connection objects provided by this
    /// Environment.
    type: []const u8,

    pub const json_field_names = .{
        .activation_page_url = "activationPageUrl",
        .bandwidths = "bandwidths",
        .environment_id = "environmentId",
        .location = "location",
        .provider = "provider",
        .remote_identifier_type = "remoteIdentifierType",
        .state = "state",
        .type = "type",
    };
};
