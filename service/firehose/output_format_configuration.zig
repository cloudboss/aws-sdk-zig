const Serializer = @import("serializer.zig").Serializer;

/// Specifies the serializer that you want Firehose to use to convert the
/// format of your data before it writes it to Amazon S3. This parameter is
/// required if
/// `Enabled` is set to true.
pub const OutputFormatConfiguration = struct {
    /// Specifies which serializer to use. You can choose either the ORC SerDe or
    /// the Parquet
    /// SerDe. If both are non-null, the server rejects the request.
    serializer: ?Serializer,

    pub const json_field_names = .{
        .serializer = "Serializer",
    };
};
