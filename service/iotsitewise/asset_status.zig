const ErrorDetails = @import("error_details.zig").ErrorDetails;
const AssetState = @import("asset_state.zig").AssetState;

/// Contains information about the current status of an asset. For more
/// information, see
/// [Asset and model
/// states](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/asset-and-model-states.html) in the *IoT SiteWise User Guide*.
pub const AssetStatus = struct {
    /// Contains associated error information, if any.
    @"error": ?ErrorDetails,

    /// The current status of the asset.
    state: AssetState,

    pub const json_field_names = .{
        .@"error" = "error",
        .state = "state",
    };
};
