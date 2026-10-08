const ProvenanceRelation = @import("provenance_relation.zig").ProvenanceRelation;
const SourceType = @import("source_type.zig").SourceType;

/// A condensed provenance entry surfaced in list results. Contains the source
/// identity of a lineage entry without the source details returned by
/// `GetRegistryRecord`.
pub const ProvenanceSummary = struct {
    /// The relationship between the registry record and its upstream source.
    /// `DETECTED_FROM` indicates that the record was auto-detected from the source
    /// resource.
    relation: ProvenanceRelation,

    /// The identifier of the upstream source that the registry record was detected
    /// from.
    source_id: []const u8,

    /// The type of the upstream source that the registry record was detected from.
    source_type: ?SourceType = null,

    pub const json_field_names = .{
        .relation = "relation",
        .source_id = "sourceId",
        .source_type = "sourceType",
    };
};
