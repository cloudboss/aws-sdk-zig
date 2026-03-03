const CallingSettings = @import("calling_settings.zig").CallingSettings;
const PasswordRequirements = @import("password_requirements.zig").PasswordRequirements;
const WickrAwsNetworks = @import("wickr_aws_networks.zig").WickrAwsNetworks;
const PermittedWickrEnterpriseNetwork = @import("permitted_wickr_enterprise_network.zig").PermittedWickrEnterpriseNetwork;
const ShredderSettings = @import("shredder_settings.zig").ShredderSettings;

/// Comprehensive configuration settings that define all user capabilities,
/// restrictions, and features for members of a security group. These settings
/// control everything from calling permissions to federation settings to
/// security policies.
pub const SecurityGroupSettings = struct {
    /// Requires users to reauthenticate every time they return to the application,
    /// providing an additional layer of security.
    always_reauthenticate: ?bool = null,

    /// Configuration values for ATAK (Android Team Awareness Kit) package
    /// integration, when ATAK is enabled.
    atak_package_values: ?[]const []const u8 = null,

    /// The calling feature permissions and settings that control what types of
    /// calls users can initiate and participate in.
    calling: ?CallingSettings = null,

    /// Enables automatic checking for Wickr client updates to ensure users stay
    /// current with the latest version.
    check_for_updates: ?bool = null,

    /// Enables ATAK (Android Team Awareness Kit) integration for tactical
    /// communication and situational awareness.
    enable_atak: ?bool = null,

    /// Allow users to report crashes.
    enable_crash_reports: ?bool = null,

    /// Specifies whether users can download files from messages to their devices.
    enable_file_download: ?bool = null,

    /// Allows users to communicate with guest users from other Wickr networks and
    /// federated external networks.
    enable_guest_federation: ?bool = null,

    /// Enables message preview text in push notifications, allowing users to see
    /// message content before opening the app.
    enable_notification_preview: ?bool = null,

    /// Allow users to avoid censorship when they are geo-blocked or have network
    /// limitations.
    enable_open_access_option: ?bool = null,

    /// Enables restricted global federation, limiting external communication to
    /// only specified permitted networks.
    enable_restricted_global_federation: ?bool = null,

    /// The local federation mode controlling how users can communicate with other
    /// networks. Values: 0 (none), 1 (federated), 2 (restricted).
    federation_mode: ?i32 = null,

    /// Enables file sharing capabilities, allowing users to send and receive files
    /// in conversations.
    files_enabled: ?bool = null,

    /// Defines the number of failed login attempts before data stored on the device
    /// is reset. Should be less than lockoutThreshold.
    force_device_lockout: ?i32 = null,

    /// Automatically enable and enforce Wickr open access on all devices. Valid
    /// only if enableOpenAccessOption settings is enabled.
    force_open_access: ?bool = null,

    /// Allow user approved bots to read messages in rooms without using a slash
    /// command.
    force_read_receipts: ?bool = null,

    /// Allows users to communicate with users on other Wickr instances (Wickr
    /// Enterprise) outside the current network.
    global_federation: ?bool = null,

    /// Enforces a two-factor authentication when a user adds a new device to their
    /// account.
    is_ato_enabled: ?bool = null,

    /// Enables automatic preview of links shared in messages, showing webpage
    /// thumbnails and descriptions.
    is_link_preview_enabled: ?bool = null,

    /// Allows map integration in location sharing, enabling users to view shared
    /// locations on interactive maps. Only allowed when location setting is
    /// enabled.
    location_allow_maps: ?bool = null,

    /// Enables location sharing features, allowing users to share their current
    /// location with others.
    location_enabled: ?bool = null,

    /// The number of failed password attempts before a user account is locked out.
    lockout_threshold: ?i32 = null,

    /// The maximum file size in bytes that will be automatically downloaded without
    /// user confirmation. Only allowed if fileDownload is enabled. Valid Values
    /// [512000 (low_quality), 7340032 (high_quality) ]
    max_auto_download_size: ?i64 = null,

    /// The maximum burn-on-read (BOR) time in seconds, which determines how long
    /// messages remain visible before auto-deletion after being read.
    max_bor: ?i32 = null,

    /// The maximum time-to-live (TTL) in seconds for messages, after which they
    /// will be automatically deleted from all devices.
    max_ttl: ?i64 = null,

    /// Enables message forwarding, allowing users to forward messages from one
    /// conversation to another.
    message_forwarding_enabled: ?bool = null,

    /// The password complexity requirements that users must follow when creating or
    /// changing passwords.
    password_requirements: ?PasswordRequirements = null,

    /// A list of network IDs that are permitted for local federation when
    /// federation mode is set to restricted.
    permitted_networks: ?[]const []const u8 = null,

    /// A list of permitted Wickr networks for global federation, restricting
    /// communication to specific approved networks.
    permitted_wickr_aws_networks: ?[]const WickrAwsNetworks = null,

    /// A list of permitted Wickr Enterprise networks for global federation,
    /// restricting communication to specific approved networks.
    permitted_wickr_enterprise_networks: ?[]const PermittedWickrEnterpriseNetwork = null,

    /// Enables presence indicators that show whether users are online, away, or
    /// offline.
    presence_enabled: ?bool = null,

    /// A list of pre-defined quick response message templates that users can send
    /// with a single tap.
    quick_responses: ?[]const []const u8 = null,

    /// Users will get a master recovery key that can be used to securely sign in to
    /// their Wickr account without having access to their primary device for
    /// authentication. Available in SSO enabled network.
    show_master_recovery_key: ?bool = null,

    /// The message shredder configuration that controls secure deletion of messages
    /// and files from devices.
    shredder: ?ShredderSettings = null,

    /// The duration for which users SSO session remains inactive before
    /// automatically logging them out for security. Available in SSO enabled
    /// network.
    sso_max_idle_minutes: ?i32 = null,

    pub const json_field_names = .{
        .always_reauthenticate = "alwaysReauthenticate",
        .atak_package_values = "atakPackageValues",
        .calling = "calling",
        .check_for_updates = "checkForUpdates",
        .enable_atak = "enableAtak",
        .enable_crash_reports = "enableCrashReports",
        .enable_file_download = "enableFileDownload",
        .enable_guest_federation = "enableGuestFederation",
        .enable_notification_preview = "enableNotificationPreview",
        .enable_open_access_option = "enableOpenAccessOption",
        .enable_restricted_global_federation = "enableRestrictedGlobalFederation",
        .federation_mode = "federationMode",
        .files_enabled = "filesEnabled",
        .force_device_lockout = "forceDeviceLockout",
        .force_open_access = "forceOpenAccess",
        .force_read_receipts = "forceReadReceipts",
        .global_federation = "globalFederation",
        .is_ato_enabled = "isAtoEnabled",
        .is_link_preview_enabled = "isLinkPreviewEnabled",
        .location_allow_maps = "locationAllowMaps",
        .location_enabled = "locationEnabled",
        .lockout_threshold = "lockoutThreshold",
        .max_auto_download_size = "maxAutoDownloadSize",
        .max_bor = "maxBor",
        .max_ttl = "maxTtl",
        .message_forwarding_enabled = "messageForwardingEnabled",
        .password_requirements = "passwordRequirements",
        .permitted_networks = "permittedNetworks",
        .permitted_wickr_aws_networks = "permittedWickrAwsNetworks",
        .permitted_wickr_enterprise_networks = "permittedWickrEnterpriseNetworks",
        .presence_enabled = "presenceEnabled",
        .quick_responses = "quickResponses",
        .show_master_recovery_key = "showMasterRecoveryKey",
        .shredder = "shredder",
        .sso_max_idle_minutes = "ssoMaxIdleMinutes",
    };
};
