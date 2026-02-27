const ProtectStatus = @import("protect_status.zig").ProtectStatus;

/// The types of statuses that can be used.
pub const ProtectConfigurationCountryRuleSetInformation = struct {
    /// The types of protection that can be used.
    protect_status: ProtectStatus,

    pub const json_field_names = .{
        .protect_status = "ProtectStatus",
    };
};
