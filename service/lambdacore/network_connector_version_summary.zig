const NetworkConnectorState = @import("network_connector_state.zig").NetworkConnectorState;
const NetworkConnectorStateReasonCode = @import("network_connector_state_reason_code.zig").NetworkConnectorStateReasonCode;

/// Summary information about a single version of a network connector returned
/// by `ListNetworkConnectorVersions`. Each configuration update creates a new
/// immutable version; this shape describes one such version. To retrieve the
/// full configuration of a version, call `GetNetworkConnector` with a
/// version-qualified identifier.
pub const NetworkConnectorVersionSummary = struct {
    /// The unqualified ARN of the network connector that this version belongs to.
    arn: []const u8,

    /// The unique identifier of the network connector.
    id: []const u8,

    /// The date and time when this connector version was last modified.
    last_modified: ?i64 = null,

    /// The name of the network connector.
    name: []const u8,

    /// The current state of this connector version.
    state: NetworkConnectorState,

    /// A human-readable explanation of the current state, populated when the state
    /// is `FAILED`.
    state_reason: ?[]const u8 = null,

    /// A machine-readable code indicating the reason for the current state. Use
    /// this for programmatic error handling.
    state_reason_code: ?NetworkConnectorStateReasonCode = null,

    /// The version number of this connector version.
    version: i64,

    /// The qualified ARN of this connector version, including the immutable version
    /// suffix.
    version_arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .last_modified = "LastModified",
        .name = "Name",
        .state = "State",
        .state_reason = "StateReason",
        .state_reason_code = "StateReasonCode",
        .version = "Version",
        .version_arn = "VersionArn",
    };
};
