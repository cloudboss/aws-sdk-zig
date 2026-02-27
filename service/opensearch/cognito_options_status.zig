const CognitoOptions = @import("cognito_options.zig").CognitoOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The status of the Cognito options for the specified domain.
pub const CognitoOptionsStatus = struct {
    /// Cognito options for the specified domain.
    options: CognitoOptions,

    /// The status of the Cognito options for the specified domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
