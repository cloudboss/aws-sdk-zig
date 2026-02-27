const IdentityCenterOptions = @import("identity_center_options.zig").IdentityCenterOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The status of IAM Identity Center configuration settings for a domain.
pub const IdentityCenterOptionsStatus = struct {
    /// Configuration settings for IAM Identity Center integration.
    options: IdentityCenterOptions,

    /// The status of IAM Identity Center configuration settings for a domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
