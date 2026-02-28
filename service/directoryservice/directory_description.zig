const DirectoryConnectSettingsDescription = @import("directory_connect_settings_description.zig").DirectoryConnectSettingsDescription;
const DirectoryEdition = @import("directory_edition.zig").DirectoryEdition;
const HybridSettingsDescription = @import("hybrid_settings_description.zig").HybridSettingsDescription;
const NetworkType = @import("network_type.zig").NetworkType;
const OSVersion = @import("os_version.zig").OSVersion;
const OwnerDirectoryDescription = @import("owner_directory_description.zig").OwnerDirectoryDescription;
const RadiusSettings = @import("radius_settings.zig").RadiusSettings;
const RadiusStatus = @import("radius_status.zig").RadiusStatus;
const RegionsInfo = @import("regions_info.zig").RegionsInfo;
const ShareMethod = @import("share_method.zig").ShareMethod;
const ShareStatus = @import("share_status.zig").ShareStatus;
const DirectorySize = @import("directory_size.zig").DirectorySize;
const DirectoryStage = @import("directory_stage.zig").DirectoryStage;
const DirectoryType = @import("directory_type.zig").DirectoryType;
const DirectoryVpcSettingsDescription = @import("directory_vpc_settings_description.zig").DirectoryVpcSettingsDescription;

/// Contains information about an Directory Service directory.
pub const DirectoryDescription = struct {
    /// The access URL for the directory, such as
    /// `http://.awsapps.com`. If no alias exists,
    /// `` is the directory identifier, such as
    /// `d-XXXXXXXXXX`.
    access_url: ?[]const u8,

    /// The alias for the directory. If no alias exists, the alias is the directory
    /// identifier,
    /// such as `d-XXXXXXXXXX`.
    alias: ?[]const u8,

    /// DirectoryConnectSettingsDescription object that contains additional
    /// information about an AD Connector directory. Present only for AD Connector
    /// directories.
    connect_settings: ?DirectoryConnectSettingsDescription,

    /// The description for the directory.
    description: ?[]const u8,

    /// The desired number of domain controllers in the directory if the directory
    /// is Microsoft
    /// AD.
    desired_number_of_domain_controllers: ?i32,

    /// The directory identifier.
    directory_id: ?[]const u8,

    /// The IP addresses of the DNS servers for the directory. For a Simple AD or
    /// Microsoft AD
    /// directory, these are the IP addresses of the Simple AD or Microsoft AD
    /// directory servers.
    /// For an AD Connector directory, these are the IP addresses of self-managed
    /// directory to which
    /// the AD Connector is connected.
    dns_ip_addrs: ?[]const []const u8,

    /// The IPv6 addresses of the DNS servers for the directory. For a Simple AD or
    /// Microsoft AD
    /// directory, these are the IPv6 addresses of the Simple AD or Microsoft AD
    /// directory servers.
    /// For an AD Connector directory, these are the IPv6 addresses of the DNS
    /// servers or domain
    /// controllers in your self-managed directory to which the AD Connector is
    /// connected.
    dns_ipv_6_addrs: ?[]const []const u8,

    /// The edition associated with this directory.
    edition: ?DirectoryEdition,

    /// Contains information about the hybrid directory configuration for the
    /// directory,
    /// including Amazon Web Services System Manager managed node identifiers and
    /// DNS IPs.
    hybrid_settings: ?HybridSettingsDescription,

    /// The date and time when the directory was created.
    launch_time: ?i64,

    /// The fully qualified name of the directory.
    name: ?[]const u8,

    /// The network type of the directory.
    network_type: ?NetworkType,

    /// The operating system (OS) version of the directory.
    os_version: ?OSVersion,

    /// Describes the Managed Microsoft AD directory in the directory owner account.
    owner_directory_description: ?OwnerDirectoryDescription,

    /// Information about the RadiusSettings object configured for this
    /// directory.
    radius_settings: ?RadiusSettings,

    /// The status of the RADIUS MFA server connection.
    radius_status: ?RadiusStatus,

    /// Lists the Regions where the directory has replicated.
    regions_info: ?RegionsInfo,

    /// The method used when sharing a directory to determine whether the directory
    /// should be
    /// shared within your Amazon Web Services organization (`ORGANIZATIONS`) or
    /// with any Amazon Web Services account
    /// by sending a shared directory request (`HANDSHAKE`).
    share_method: ?ShareMethod,

    /// A directory share request that is sent by the directory owner to the
    /// directory consumer.
    /// The request includes a typed message to help the directory consumer
    /// administrator determine
    /// whether to approve or reject the share invitation.
    share_notes: ?[]const u8,

    /// Current directory status of the shared Managed Microsoft AD directory.
    share_status: ?ShareStatus,

    /// The short name of the directory.
    short_name: ?[]const u8,

    /// The directory size.
    size: ?DirectorySize,

    /// Indicates whether single sign-on is enabled for the directory. For more
    /// information, see
    /// EnableSso and DisableSso.
    sso_enabled: bool = false,

    /// The current stage of the directory.
    stage: ?DirectoryStage,

    /// The date and time when the stage was last updated.
    stage_last_updated_date_time: ?i64,

    /// Additional information about the directory stage.
    stage_reason: ?[]const u8,

    /// The directory type.
    type: ?DirectoryType,

    /// A DirectoryVpcSettingsDescription object that contains additional
    /// information about a directory. Present only for Simple AD and Managed
    /// Microsoft AD
    /// directories.
    vpc_settings: ?DirectoryVpcSettingsDescription,

    pub const json_field_names = .{
        .access_url = "AccessUrl",
        .alias = "Alias",
        .connect_settings = "ConnectSettings",
        .description = "Description",
        .desired_number_of_domain_controllers = "DesiredNumberOfDomainControllers",
        .directory_id = "DirectoryId",
        .dns_ip_addrs = "DnsIpAddrs",
        .dns_ipv_6_addrs = "DnsIpv6Addrs",
        .edition = "Edition",
        .hybrid_settings = "HybridSettings",
        .launch_time = "LaunchTime",
        .name = "Name",
        .network_type = "NetworkType",
        .os_version = "OsVersion",
        .owner_directory_description = "OwnerDirectoryDescription",
        .radius_settings = "RadiusSettings",
        .radius_status = "RadiusStatus",
        .regions_info = "RegionsInfo",
        .share_method = "ShareMethod",
        .share_notes = "ShareNotes",
        .share_status = "ShareStatus",
        .short_name = "ShortName",
        .size = "Size",
        .sso_enabled = "SsoEnabled",
        .stage = "Stage",
        .stage_last_updated_date_time = "StageLastUpdatedDateTime",
        .stage_reason = "StageReason",
        .type = "Type",
        .vpc_settings = "VpcSettings",
    };
};
