const RdsSalSettings = @import("rds_sal_settings.zig").RdsSalSettings;

/// Contains settings for a specific server.
pub const ServerSettings = union(enum) {
    /// The `RdsSalSettings` resource contains settings to configure a specific
    /// Remote Desktop Services (RDS) license server.
    rds_sal_settings: ?RdsSalSettings,

    pub const json_field_names = .{
        .rds_sal_settings = "RdsSalSettings",
    };
};
