const ConnectivityProperties = @import("connectivity_properties.zig").ConnectivityProperties;
const IdentityMapping = @import("identity_mapping.zig").IdentityMapping;
const LineageSyncInput = @import("lineage_sync_input.zig").LineageSyncInput;

/// Contains the Snowflake-specific settings required when creating or updating
/// a connection, including the Snowflake role, identity mapping, and lineage
/// sync configuration.
pub const SnowflakePropertiesInput = struct {
    /// The connectivity properties of the Snowflake connection.
    connectivity_properties: ?ConnectivityProperties = null,

    /// The identity mapping configuration for the Snowflake connection.
    identity_mapping: IdentityMapping,

    /// The lineage sync configuration for the Snowflake connection.
    lineage_sync: ?LineageSyncInput = null,

    /// The Snowflake role used to access Snowflake resources.
    snowflake_role: []const u8,

    pub const json_field_names = .{
        .connectivity_properties = "connectivityProperties",
        .identity_mapping = "identityMapping",
        .lineage_sync = "lineageSync",
        .snowflake_role = "snowflakeRole",
    };
};
