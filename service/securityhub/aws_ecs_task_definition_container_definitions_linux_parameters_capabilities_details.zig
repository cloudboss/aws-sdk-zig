/// The Linux capabilities for the container that are added to or dropped from
/// the default configuration provided by Docker.
pub const AwsEcsTaskDefinitionContainerDefinitionsLinuxParametersCapabilitiesDetails = struct {
    /// The Linux capabilities for the container that are added to the default
    /// configuration provided by Docker. Valid values are as follows:
    ///
    /// Valid values: `"ALL"` | `"AUDIT_CONTROL"` |` "AUDIT_WRITE"` |
    /// `"BLOCK_SUSPEND"` | `"CHOWN"` | `"DAC_OVERRIDE"` |
    /// `"DAC_READ_SEARCH"` | `"FOWNER"` | `"FSETID"` |
    /// `"IPC_LOCK"` | `"IPC_OWNER"` | `"KILL"` |
    /// `"LEASE"` | `"LINUX_IMMUTABLE"` | `"MAC_ADMIN"` |`
    /// "MAC_OVERRIDE"` | `"MKNOD"` | `"NET_ADMIN"` |
    /// `"NET_BIND_SERVICE"` | `"NET_BROADCAST"` | `"NET_RAW"` |
    /// `"SETFCAP"` | `"SETGID"` | `"SETPCAP"` |
    /// `"SETUID"` | `"SYS_ADMIN"` | `"SYS_BOOT"` |
    /// `"SYS_CHROOT"` | `"SYS_MODULE"` | `"SYS_NICE"` |
    /// `"SYS_PACCT"` | `"SYS_PTRACE"` | `"SYS_RAWIO"` |
    /// `"SYS_RESOURCE"` | `"SYS_TIME"` | `"SYS_TTY_CONFIG"` |
    /// `"SYSLOG"` | `"WAKE_ALARM"`
    add: ?[]const []const u8,

    /// The Linux capabilities for the container that are dropped from the default
    /// configuration provided by Docker.
    ///
    /// Valid values: `"ALL"` | `"AUDIT_CONTROL"` |` "AUDIT_WRITE"` |
    /// `"BLOCK_SUSPEND"` | `"CHOWN"` | `"DAC_OVERRIDE"` |
    /// `"DAC_READ_SEARCH"` | `"FOWNER"` | `"FSETID"` |
    /// `"IPC_LOCK"` | `"IPC_OWNER"` | `"KILL"` |
    /// `"LEASE"` | `"LINUX_IMMUTABLE"` | `"MAC_ADMIN"` |`
    /// "MAC_OVERRIDE"` | `"MKNOD"` | `"NET_ADMIN"` |
    /// `"NET_BIND_SERVICE"` | `"NET_BROADCAST"` | `"NET_RAW"` |
    /// `"SETFCAP"` | `"SETGID"` | `"SETPCAP"` |
    /// `"SETUID"` | `"SYS_ADMIN"` | `"SYS_BOOT"` |
    /// `"SYS_CHROOT"` | `"SYS_MODULE"` | `"SYS_NICE"` |
    /// `"SYS_PACCT"` | `"SYS_PTRACE"` | `"SYS_RAWIO"` |
    /// `"SYS_RESOURCE"` | `"SYS_TIME"` | `"SYS_TTY_CONFIG"` |
    /// `"SYSLOG"` | `"WAKE_ALARM"`
    drop: ?[]const []const u8,

    pub const json_field_names = .{
        .add = "Add",
        .drop = "Drop",
    };
};
