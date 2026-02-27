const AdvancedSecurityOptions = @import("advanced_security_options.zig").AdvancedSecurityOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The status of fine-grained access control settings for a domain.
pub const AdvancedSecurityOptionsStatus = struct {
    /// Container for fine-grained access control settings.
    options: AdvancedSecurityOptions,

    /// Status of the fine-grained access control settings for a domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
