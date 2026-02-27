const aws = @import("aws");

const IcebergSchema = @import("iceberg_schema.zig").IcebergSchema;

/// Contains details about the metadata for an Iceberg table.
pub const IcebergMetadata = struct {
    /// Contains configuration properties for an Iceberg table.
    properties: ?[]const aws.map.StringMapEntry,

    /// The schema for an Iceberg table.
    schema: IcebergSchema,

    pub const json_field_names = .{
        .properties = "properties",
        .schema = "schema",
    };
};
