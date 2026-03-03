const IcebergInput = @import("iceberg_input.zig").IcebergInput;

/// A structure representing an open format table.
pub const OpenTableFormatInput = struct {
    /// Specifies an `IcebergInput` structure that defines an Apache Iceberg
    /// metadata table.
    iceberg_input: ?IcebergInput = null,

    pub const json_field_names = .{
        .iceberg_input = "IcebergInput",
    };
};
