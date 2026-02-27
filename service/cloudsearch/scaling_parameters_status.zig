const ScalingParameters = @import("scaling_parameters.zig").ScalingParameters;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The status and configuration of a search domain's scaling parameters.
pub const ScalingParametersStatus = struct {
    options: ScalingParameters,

    status: OptionStatus,
};
