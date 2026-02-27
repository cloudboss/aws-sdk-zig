const JsonConfiguration = @import("json_configuration.zig").JsonConfiguration;
const ParquetConfiguration = @import("parquet_configuration.zig").ParquetConfiguration;

/// Contains the configuration information of file formats. IoT Analytics data
/// stores support JSON and [Parquet](https://parquet.apache.org/).
///
/// The default file format is JSON. You can specify only one format.
///
/// You can't change the file format after you create the data store.
pub const FileFormatConfiguration = struct {
    /// Contains the configuration information of the JSON format.
    json_configuration: ?JsonConfiguration,

    /// Contains the configuration information of the Parquet format.
    parquet_configuration: ?ParquetConfiguration,

    pub const json_field_names = .{
        .json_configuration = "jsonConfiguration",
        .parquet_configuration = "parquetConfiguration",
    };
};
