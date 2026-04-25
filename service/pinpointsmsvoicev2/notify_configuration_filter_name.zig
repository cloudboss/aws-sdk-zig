const std = @import("std");

/// The filter name for filtering notify configurations. The available filter
/// names are:
///
/// * `default-pool`: Filter by the default pool.
/// * `default-template`: Filter by the default template.
/// * `deletion-protection-enabled`: Filter by deletion protection status.
/// * `display-name`: Filter by display name.
/// * `enabled-channels`: Filter by enabled channels.
/// * `enabled-countries`: Filter by enabled countries.
/// * `status`: Filter by status.
/// * `tier-upgrade-status`: Filter by tier upgrade status.
/// * `use-case`: Filter by use case.
pub const NotifyConfigurationFilterName = enum {
    display_name,
    enabled_countries,
    enabled_channels,
    default_template,
    default_pool,
    use_case,
    status,
    deletion_protection_enabled,
    tier_upgrade_status,

    pub const json_field_names = .{
        .display_name = "display-name",
        .enabled_countries = "enabled-countries",
        .enabled_channels = "enabled-channels",
        .default_template = "default-template",
        .default_pool = "default-pool",
        .use_case = "use-case",
        .status = "status",
        .deletion_protection_enabled = "deletion-protection-enabled",
        .tier_upgrade_status = "tier-upgrade-status",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .display_name => "display-name",
            .enabled_countries => "enabled-countries",
            .enabled_channels => "enabled-channels",
            .default_template => "default-template",
            .default_pool => "default-pool",
            .use_case => "use-case",
            .status => "status",
            .deletion_protection_enabled => "deletion-protection-enabled",
            .tier_upgrade_status => "tier-upgrade-status",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
