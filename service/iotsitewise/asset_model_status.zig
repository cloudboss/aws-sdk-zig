const ErrorDetails = @import("error_details.zig").ErrorDetails;
const AssetModelState = @import("asset_model_state.zig").AssetModelState;

/// Contains current status information for an asset model. For more
/// information, see [Asset and model
/// states](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/asset-and-model-states.html) in the *IoT SiteWise User Guide*.
pub const AssetModelStatus = struct {
    /// Contains associated error information, if any.
    @"error": ?ErrorDetails,

    /// The current state of the asset model.
    state: AssetModelState,

    pub const json_field_names = .{
        .@"error" = "error",
        .state = "state",
    };
};
