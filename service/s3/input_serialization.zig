const CompressionType = @import("compression_type.zig").CompressionType;
const CSVInput = @import("csv_input.zig").CSVInput;
const JSONInput = @import("json_input.zig").JSONInput;
const ParquetInput = @import("parquet_input.zig").ParquetInput;

/// Describes the serialization format of the object.
pub const InputSerialization = struct {
    /// Specifies object's compression format. Valid values: NONE, GZIP, BZIP2.
    /// Default Value: NONE.
    compression_type: ?CompressionType = null,

    /// Describes the serialization of a CSV-encoded object.
    csv: ?CSVInput = null,

    /// Specifies JSON as object's input serialization format.
    json: ?JSONInput = null,

    /// Specifies Parquet as object's input serialization format.
    parquet: ?ParquetInput = null,
};
