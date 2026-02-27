const CognitoOptions = @import("cognito_options.zig").CognitoOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// Status of the Cognito options for the specified Elasticsearch domain.
pub const CognitoOptionsStatus = struct {
    /// Specifies the Cognito options for the specified Elasticsearch domain.
    options: CognitoOptions,

    /// Specifies the status of the Cognito options for the specified Elasticsearch
    /// domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
