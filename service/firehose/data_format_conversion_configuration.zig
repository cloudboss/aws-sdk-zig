const InputFormatConfiguration = @import("input_format_configuration.zig").InputFormatConfiguration;
const OutputFormatConfiguration = @import("output_format_configuration.zig").OutputFormatConfiguration;
const SchemaConfiguration = @import("schema_configuration.zig").SchemaConfiguration;

/// Specifies that you want Firehose to convert data from the JSON format to
/// the Parquet or ORC format before writing it to Amazon S3. Firehose uses the
/// serializer and deserializer that you specify, in addition to the column
/// information from
/// the Amazon Web Services Glue table, to deserialize your input data from JSON
/// and then
/// serialize it to the Parquet or ORC format. For more information, see
/// [Firehose Record Format
/// Conversion](https://docs.aws.amazon.com/firehose/latest/dev/record-format-conversion.html).
pub const DataFormatConversionConfiguration = struct {
    /// Defaults to `true`. Set it to `false` if you want to disable
    /// format conversion while preserving the configuration details.
    enabled: ?bool = null,

    /// Specifies the deserializer that you want Firehose to use to convert the
    /// format of your data from JSON. This parameter is required if `Enabled` is
    /// set to
    /// true.
    input_format_configuration: ?InputFormatConfiguration = null,

    /// Specifies the serializer that you want Firehose to use to convert the
    /// format of your data to the Parquet or ORC format. This parameter is required
    /// if
    /// `Enabled` is set to true.
    output_format_configuration: ?OutputFormatConfiguration = null,

    /// Specifies the Amazon Web Services Glue Data Catalog table that contains the
    /// column
    /// information. This parameter is required if `Enabled` is set to true.
    schema_configuration: ?SchemaConfiguration = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .input_format_configuration = "InputFormatConfiguration",
        .output_format_configuration = "OutputFormatConfiguration",
        .schema_configuration = "SchemaConfiguration",
    };
};
