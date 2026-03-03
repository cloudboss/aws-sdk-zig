const DataSource = @import("data_source.zig").DataSource;
const Total = @import("total.zig").Total;

/// Contains information on the result of usage based on data source type.
pub const UsageDataSourceResult = struct {
    /// The data source type that generated usage.
    data_source: ?DataSource = null,

    /// Represents the total of usage for the specified data source.
    total: ?Total = null,

    pub const json_field_names = .{
        .data_source = "DataSource",
        .total = "Total",
    };
};
