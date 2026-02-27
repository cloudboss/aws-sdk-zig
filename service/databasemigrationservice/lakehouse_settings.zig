/// Provides information that defines a Lakehouse endpoint. This endpoint type
/// is used for
/// zero-ETL integrations with Lakehouse data warehouses.
pub const LakehouseSettings = struct {
    /// The Amazon Resource Name (ARN) of the Lakehouse resource that serves as the
    /// target for
    /// this endpoint.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
