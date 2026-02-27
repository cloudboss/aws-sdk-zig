const OrcSerDe = @import("orc_ser_de.zig").OrcSerDe;
const ParquetSerDe = @import("parquet_ser_de.zig").ParquetSerDe;

/// The serializer that you want Firehose to use to convert data to the target
/// format before writing it to Amazon S3. Firehose supports two types of
/// serializers: the ORC SerDe and the Parquet SerDe.
pub const Serializer = struct {
    /// A serializer to use for converting data to the ORC format before storing it
    /// in Amazon
    /// S3. For more information, see [Apache
    /// ORC](https://orc.apache.org/docs/).
    orc_ser_de: ?OrcSerDe,

    /// A serializer to use for converting data to the Parquet format before storing
    /// it in
    /// Amazon S3. For more information, see [Apache
    /// Parquet](https://parquet.apache.org/docs/contribution-guidelines/).
    parquet_ser_de: ?ParquetSerDe,

    pub const json_field_names = .{
        .orc_ser_de = "OrcSerDe",
        .parquet_ser_de = "ParquetSerDe",
    };
};
