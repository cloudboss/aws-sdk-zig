const SignalFetchConfig = @import("signal_fetch_config.zig").SignalFetchConfig;

/// Information about the signal to be fetched.
///
/// Access to certain Amazon Web Services IoT FleetWise features is currently
/// gated. For more information, see [Amazon Web Services Region and feature
/// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
pub const SignalFetchInformation = struct {
    /// The actions to be performed by the signal fetch.
    actions: []const []const u8,

    /// The version of the condition language used.
    condition_language_version: ?i32 = null,

    /// The fully qualified name of the signal to be fetched.
    fully_qualified_name: []const u8,

    /// The configuration of the signal fetch operation.
    signal_fetch_config: SignalFetchConfig,

    pub const json_field_names = .{
        .actions = "actions",
        .condition_language_version = "conditionLanguageVersion",
        .fully_qualified_name = "fullyQualifiedName",
        .signal_fetch_config = "signalFetchConfig",
    };
};
