const DataQualityGlueTable = @import("data_quality_glue_table.zig").DataQualityGlueTable;
const GlueTable = @import("glue_table.zig").GlueTable;

/// A data source (an Glue table) for which you want data quality results.
pub const DataSource = struct {
    /// An Glue table for Data Quality Operations.
    data_quality_glue_table: ?DataQualityGlueTable,

    /// An Glue table.
    glue_table: ?GlueTable,

    pub const json_field_names = .{
        .data_quality_glue_table = "DataQualityGlueTable",
        .glue_table = "GlueTable",
    };
};
