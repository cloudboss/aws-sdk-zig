pub const ProcessorType = enum {
    record_de_aggregation,
    decompression,
    cloud_watch_log_processing,
    lambda,
    metadata_extraction,
    append_delimiter_to_record,

    pub const json_field_names = .{
        .record_de_aggregation = "RecordDeAggregation",
        .decompression = "Decompression",
        .cloud_watch_log_processing = "CloudWatchLogProcessing",
        .lambda = "Lambda",
        .metadata_extraction = "MetadataExtraction",
        .append_delimiter_to_record = "AppendDelimiterToRecord",
    };
};
