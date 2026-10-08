const ProvenanceRelation = @import("provenance_relation.zig").ProvenanceRelation;
const SourceDetails = @import("source_details.zig").SourceDetails;
const SourceType = @import("source_type.zig").SourceType;

/// A provenance entry that describes the lineage of a registry record. Records
/// that were auto-detected by Amazon Web Services Agent Registry carry a
/// provenance entry that links the record back to its upstream source.
pub const Provenance = struct {
    /// The relationship between the registry record and its upstream source.
    /// `DETECTED_FROM` indicates that the record was auto-detected from the source
    /// resource.
    relation: ProvenanceRelation,

    /// Additional details about the upstream source that the registry record was
    /// detected from, such as the AgentCore Gateway or Runtime configuration. The
    /// populated member corresponds to the source type.
    source_details: ?SourceDetails = null,

    /// The identifier of the upstream source that the registry record was detected
    /// from.
    source_id: []const u8,

    /// The type of the upstream source that the registry record was detected from.
    source_type: ?SourceType = null,

    pub const json_field_names = .{
        .relation = "relation",
        .source_details = "sourceDetails",
        .source_id = "sourceId",
        .source_type = "sourceType",
    };
};
