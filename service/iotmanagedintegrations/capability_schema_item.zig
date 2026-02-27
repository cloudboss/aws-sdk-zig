const SchemaVersionFormat = @import("schema_version_format.zig").SchemaVersionFormat;

/// Structure representing a capability schema item that defines the
/// functionality and features supported by a managed thing.
pub const CapabilitySchemaItem = struct {
    /// The unique identifier of the capability defined in the schema.
    capability_id: []const u8,

    /// The external identifier for the capability, used when referencing the
    /// capability outside of the AWS ecosystem.
    extrinsic_id: []const u8,

    /// The version of the external capability definition, used to track
    /// compatibility with external systems.
    extrinsic_version: i32,

    /// The format of the capability schema, which defines how the schema is
    /// structured and interpreted.
    format: SchemaVersionFormat,

    /// The actual schema definition that describes the capability's properties,
    /// actions, and events.
    schema: []const u8,

    pub const json_field_names = .{
        .capability_id = "CapabilityId",
        .extrinsic_id = "ExtrinsicId",
        .extrinsic_version = "ExtrinsicVersion",
        .format = "Format",
        .schema = "Schema",
    };
};
