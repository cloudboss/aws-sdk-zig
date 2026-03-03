const MacSystemIntegrityProtectionSettingStatus = @import("mac_system_integrity_protection_setting_status.zig").MacSystemIntegrityProtectionSettingStatus;

/// Describes the configuration for a System Integrity Protection (SIP)
/// modification task.
pub const MacSystemIntegrityProtectionConfiguration = struct {
    /// Indicates whether Apple Internal was enabled or disabled by the task.
    apple_internal: ?MacSystemIntegrityProtectionSettingStatus = null,

    /// Indicates whether Base System was enabled or disabled by the task.
    base_system: ?MacSystemIntegrityProtectionSettingStatus = null,

    /// Indicates whether Debugging Restrictions was enabled or disabled by the
    /// task.
    debugging_restrictions: ?MacSystemIntegrityProtectionSettingStatus = null,

    /// Indicates whether Dtrace Restrictions was enabled or disabled by the task.
    d_trace_restrictions: ?MacSystemIntegrityProtectionSettingStatus = null,

    /// Indicates whether Filesystem Protections was enabled or disabled by the
    /// task.
    filesystem_protections: ?MacSystemIntegrityProtectionSettingStatus = null,

    /// Indicates whether Kext Signing was enabled or disabled by the task.
    kext_signing: ?MacSystemIntegrityProtectionSettingStatus = null,

    /// Indicates whether NVRAM Protections was enabled or disabled by the task.
    nvram_protections: ?MacSystemIntegrityProtectionSettingStatus = null,

    /// Indicates SIP was enabled or disabled by the task.
    status: ?MacSystemIntegrityProtectionSettingStatus = null,
};
