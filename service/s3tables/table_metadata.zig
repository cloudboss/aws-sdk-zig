const IcebergMetadata = @import("iceberg_metadata.zig").IcebergMetadata;

/// Contains details about the table metadata.
pub const TableMetadata = union(enum) {
    /// Contains details about the metadata of an Iceberg table.
    iceberg: ?IcebergMetadata,

    pub const json_field_names = .{
        .iceberg = "iceberg",
    };
};
