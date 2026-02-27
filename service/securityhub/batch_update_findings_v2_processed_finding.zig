const OcsfFindingIdentifier = @import("ocsf_finding_identifier.zig").OcsfFindingIdentifier;

/// The list of findings that were updated.
pub const BatchUpdateFindingsV2ProcessedFinding = struct {
    /// The finding identifier of a processed finding.
    finding_identifier: ?OcsfFindingIdentifier,

    /// The metadata.uid of a processed finding.
    metadata_uid: ?[]const u8,

    pub const json_field_names = .{
        .finding_identifier = "FindingIdentifier",
        .metadata_uid = "MetadataUid",
    };
};
