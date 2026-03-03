const OrcCompression = @import("orc_compression.zig").OrcCompression;
const OrcFormatVersion = @import("orc_format_version.zig").OrcFormatVersion;

/// A serializer to use for converting data to the ORC format before storing it
/// in Amazon
/// S3. For more information, see [Apache
/// ORC](https://orc.apache.org/docs/).
pub const OrcSerDe = struct {
    /// The Hadoop Distributed File System (HDFS) block size. This is useful if you
    /// intend to
    /// copy the data from Amazon S3 to HDFS before querying. The default is 256 MiB
    /// and the
    /// minimum is 64 MiB. Firehose uses this value for padding calculations.
    block_size_bytes: ?i32 = null,

    /// The column names for which you want Firehose to create bloom filters. The
    /// default is `null`.
    bloom_filter_columns: ?[]const []const u8 = null,

    /// The Bloom filter false positive probability (FPP). The lower the FPP, the
    /// bigger the
    /// Bloom filter. The default value is 0.05, the minimum is 0, and the maximum
    /// is 1.
    bloom_filter_false_positive_probability: ?f64 = null,

    /// The compression code to use over data blocks. The default is `SNAPPY`.
    compression: ?OrcCompression = null,

    /// Represents the fraction of the total number of non-null rows. To turn off
    /// dictionary
    /// encoding, set this fraction to a number that is less than the number of
    /// distinct keys in a
    /// dictionary. To always use dictionary encoding, set this threshold to 1.
    dictionary_key_threshold: ?f64 = null,

    /// Set this to `true` to indicate that you want stripes to be padded to the
    /// HDFS
    /// block boundaries. This is useful if you intend to copy the data from Amazon
    /// S3 to HDFS
    /// before querying. The default is `false`.
    enable_padding: ?bool = null,

    /// The version of the file to write. The possible values are `V0_11` and
    /// `V0_12`. The default is `V0_12`.
    format_version: ?OrcFormatVersion = null,

    /// A number between 0 and 1 that defines the tolerance for block padding as a
    /// decimal
    /// fraction of stripe size. The default value is 0.05, which means 5 percent of
    /// stripe
    /// size.
    ///
    /// For the default values of 64 MiB ORC stripes and 256 MiB HDFS blocks, the
    /// default block
    /// padding tolerance of 5 percent reserves a maximum of 3.2 MiB for padding
    /// within the 256 MiB
    /// block. In such a case, if the available size within the block is more than
    /// 3.2 MiB, a new,
    /// smaller stripe is inserted to fit within that space. This ensures that no
    /// stripe crosses
    /// block boundaries and causes remote reads within a node-local task.
    ///
    /// Firehose ignores this parameter when OrcSerDe$EnablePadding is `false`.
    padding_tolerance: ?f64 = null,

    /// The number of rows between index entries. The default is 10,000 and the
    /// minimum is
    /// 1,000.
    row_index_stride: ?i32 = null,

    /// The number of bytes in each stripe. The default is 64 MiB and the minimum is
    /// 8
    /// MiB.
    stripe_size_bytes: ?i32 = null,

    pub const json_field_names = .{
        .block_size_bytes = "BlockSizeBytes",
        .bloom_filter_columns = "BloomFilterColumns",
        .bloom_filter_false_positive_probability = "BloomFilterFalsePositiveProbability",
        .compression = "Compression",
        .dictionary_key_threshold = "DictionaryKeyThreshold",
        .enable_padding = "EnablePadding",
        .format_version = "FormatVersion",
        .padding_tolerance = "PaddingTolerance",
        .row_index_stride = "RowIndexStride",
        .stripe_size_bytes = "StripeSizeBytes",
    };
};
