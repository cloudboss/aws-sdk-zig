const OptionGroupOptionSetting = @import("option_group_option_setting.zig").OptionGroupOptionSetting;
const OptionVersion = @import("option_version.zig").OptionVersion;

/// Available option.
pub const OptionGroupOption = struct {
    /// Indicates whether the option can be copied across Amazon Web Services
    /// accounts.
    copyable_cross_account: ?bool = null,

    /// If the option requires a port, specifies the default port for the option.
    default_port: ?i32 = null,

    /// The description of the option.
    description: ?[]const u8 = null,

    /// The name of the engine that this option can be applied to.
    engine_name: ?[]const u8 = null,

    /// Indicates the major engine version that the option is available for.
    major_engine_version: ?[]const u8 = null,

    /// The minimum required engine version for the option to be applied.
    minimum_required_minor_engine_version: ?[]const u8 = null,

    /// The name of the option.
    name: ?[]const u8 = null,

    /// The option settings that are available (and the default value) for each
    /// option in an option group.
    option_group_option_settings: ?[]const OptionGroupOptionSetting = null,

    /// The versions that are available for the option.
    option_group_option_versions: ?[]const OptionVersion = null,

    /// The options that conflict with this option.
    options_conflicts_with: ?[]const []const u8 = null,

    /// The options that are prerequisites for this option.
    options_depended_on: ?[]const []const u8 = null,

    /// Permanent options can never be removed from an option group. An option group
    /// containing a permanent option can't be removed from a DB instance.
    permanent: ?bool = null,

    /// Persistent options can't be removed from an option group while DB instances
    /// are associated with the option group. If you disassociate all DB instances
    /// from the option group, your can remove the persistent option from the option
    /// group.
    persistent: ?bool = null,

    /// Indicates whether the option requires a port.
    port_required: ?bool = null,

    /// If true, you must enable the Auto Minor Version Upgrade setting for your DB
    /// instance before you can use this option. You can enable Auto Minor Version
    /// Upgrade when you first create your DB instance, or by modifying your DB
    /// instance later.
    requires_auto_minor_engine_version_upgrade: ?bool = null,

    /// If true, you can change the option to an earlier version of the option. This
    /// only applies to options that have different versions available.
    supports_option_version_downgrade: ?bool = null,

    /// If true, you can only use this option with a DB instance that is in a VPC.
    vpc_only: ?bool = null,
};
