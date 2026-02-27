/// The relation between two services.
pub const GraphLink = struct {
    /// Destination traces of a link relationship.
    destination_trace_ids: ?[]const []const u8,

    /// Relationship of a trace to the corresponding service.
    reference_type: ?[]const u8,

    /// Source trace of a link relationship.
    source_trace_id: ?[]const u8,

    pub const json_field_names = .{
        .destination_trace_ids = "DestinationTraceIds",
        .reference_type = "ReferenceType",
        .source_trace_id = "SourceTraceId",
    };
};
