/// Schema configuration that controls how Apache Kafka record values are
/// validated.
pub const RecordSchema = struct {
    /// The Amazon Resource Name (ARN) of the AWS Glue Schema Registry schema (not
    /// registry) used to validate records for the destination Apache Iceberg table.
    gsr_arn: []const u8,

    pub const json_field_names = .{
        .gsr_arn = "GsrArn",
    };
};
