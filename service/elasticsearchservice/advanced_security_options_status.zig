const AdvancedSecurityOptions = @import("advanced_security_options.zig").AdvancedSecurityOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// Specifies the status of advanced security options for the specified
/// Elasticsearch domain.
pub const AdvancedSecurityOptionsStatus = struct {
    /// Specifies advanced security options for the specified Elasticsearch domain.
    options: AdvancedSecurityOptions,

    /// Status of the advanced security options for the specified Elasticsearch
    /// domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
