const MacSystemIntegrityProtectionSettingStatus = @import("mac_system_integrity_protection_setting_status.zig").MacSystemIntegrityProtectionSettingStatus;

/// Describes a custom configuration for a System Integrity Protection (SIP)
/// modification task.
pub const MacSystemIntegrityProtectionConfigurationRequest = struct {
    /// Enables or disables Apple Internal.
    apple_internal: ?MacSystemIntegrityProtectionSettingStatus = null,

    /// Enables or disables Base System.
    base_system: ?MacSystemIntegrityProtectionSettingStatus = null,

    /// Enables or disables Debugging Restrictions.
    debugging_restrictions: ?MacSystemIntegrityProtectionSettingStatus = null,

    /// Enables or disables Dtrace Restrictions.
    d_trace_restrictions: ?MacSystemIntegrityProtectionSettingStatus = null,

    /// Enables or disables Filesystem Protections.
    filesystem_protections: ?MacSystemIntegrityProtectionSettingStatus = null,

    /// Enables or disables Kext Signing.
    kext_signing: ?MacSystemIntegrityProtectionSettingStatus = null,

    /// Enables or disables Nvram Protections.
    nvram_protections: ?MacSystemIntegrityProtectionSettingStatus = null,
};
