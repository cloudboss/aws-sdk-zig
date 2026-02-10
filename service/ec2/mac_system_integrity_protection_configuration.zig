const MacSystemIntegrityProtectionSettingStatus = @import("mac_system_integrity_protection_setting_status.zig").MacSystemIntegrityProtectionSettingStatus;

/// Describes the configuration for a System Integrity Protection (SIP)
/// modification task.
pub const MacSystemIntegrityProtectionConfiguration = struct {
    /// Indicates whether Apple Internal was enabled or disabled by the task.
    apple_internal: ?MacSystemIntegrityProtectionSettingStatus,

    /// Indicates whether Base System was enabled or disabled by the task.
    base_system: ?MacSystemIntegrityProtectionSettingStatus,

    /// Indicates whether Debugging Restrictions was enabled or disabled by the
    /// task.
    debugging_restrictions: ?MacSystemIntegrityProtectionSettingStatus,

    /// Indicates whether Dtrace Restrictions was enabled or disabled by the task.
    d_trace_restrictions: ?MacSystemIntegrityProtectionSettingStatus,

    /// Indicates whether Filesystem Protections was enabled or disabled by the
    /// task.
    filesystem_protections: ?MacSystemIntegrityProtectionSettingStatus,

    /// Indicates whether Kext Signing was enabled or disabled by the task.
    kext_signing: ?MacSystemIntegrityProtectionSettingStatus,

    /// Indicates whether NVRAM Protections was enabled or disabled by the task.
    nvram_protections: ?MacSystemIntegrityProtectionSettingStatus,

    /// Indicates SIP was enabled or disabled by the task.
    status: ?MacSystemIntegrityProtectionSettingStatus,
};
