const ParquetCompression = @import("parquet_compression.zig").ParquetCompression;
const ParquetWriterVersion = @import("parquet_writer_version.zig").ParquetWriterVersion;

/// A serializer to use for converting data to the Parquet format before storing
/// it in
/// Amazon S3. For more information, see [Apache
/// Parquet](https://parquet.apache.org/docs/).
pub const ParquetSerDe = struct {
    /// The Hadoop Distributed File System (HDFS) block size. This is useful if you
    /// intend to
    /// copy the data from Amazon S3 to HDFS before querying. The default is 256 MiB
    /// and the
    /// minimum is 64 MiB. Firehose uses this value for padding calculations.
    block_size_bytes: ?i32,

    /// The compression code to use over data blocks. The possible values are
    /// `UNCOMPRESSED`, `SNAPPY`, and `GZIP`, with the default
    /// being `SNAPPY`. Use `SNAPPY` for higher decompression speed. Use
    /// `GZIP` if the compression ratio is more important than speed.
    compression: ?ParquetCompression,

    /// Indicates whether to enable dictionary compression.
    enable_dictionary_compression: ?bool,

    /// The maximum amount of padding to apply. This is useful if you intend to copy
    /// the data
    /// from Amazon S3 to HDFS before querying. The default is 0.
    max_padding_bytes: ?i32,

    /// The Parquet page size. Column chunks are divided into pages. A page is
    /// conceptually an
    /// indivisible unit (in terms of compression and encoding). The minimum value
    /// is 64 KiB and
    /// the default is 1 MiB.
    page_size_bytes: ?i32,

    /// Indicates the version of row format to output. The possible values are `V1`
    /// and `V2`. The default is `V1`.
    writer_version: ?ParquetWriterVersion,

    pub const json_field_names = .{
        .block_size_bytes = "BlockSizeBytes",
        .compression = "Compression",
        .enable_dictionary_compression = "EnableDictionaryCompression",
        .max_padding_bytes = "MaxPaddingBytes",
        .page_size_bytes = "PageSizeBytes",
        .writer_version = "WriterVersion",
    };
};
