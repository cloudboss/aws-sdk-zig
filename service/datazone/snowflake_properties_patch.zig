const ConnectivityPropertiesPatch = @import("connectivity_properties_patch.zig").ConnectivityPropertiesPatch;
const LineageSyncInput = @import("lineage_sync_input.zig").LineageSyncInput;

/// Contains the Snowflake-specific settings to update on an existing
/// connection. Include only the fields you want to change.
pub const SnowflakePropertiesPatch = struct {
    /// The connectivity properties patch of the Snowflake connection.
    connectivity_properties_patch: ?ConnectivityPropertiesPatch = null,

    /// The lineage sync configuration for the Snowflake connection.
    lineage_sync: ?LineageSyncInput = null,

    /// The Snowflake role used to access Snowflake resources.
    snowflake_role: ?[]const u8 = null,

    pub const json_field_names = .{
        .connectivity_properties_patch = "connectivityPropertiesPatch",
        .lineage_sync = "lineageSync",
        .snowflake_role = "snowflakeRole",
    };
};
