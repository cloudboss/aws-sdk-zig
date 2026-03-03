const BatchUpdateFindingsV2UnprocessedFindingErrorCode = @import("batch_update_findings_v2_unprocessed_finding_error_code.zig").BatchUpdateFindingsV2UnprocessedFindingErrorCode;
const OcsfFindingIdentifier = @import("ocsf_finding_identifier.zig").OcsfFindingIdentifier;

/// The list of findings that were not updated.
pub const BatchUpdateFindingsV2UnprocessedFinding = struct {
    /// Indicates the specific type of error preventing successful processing of a
    /// finding during a batch update operation.
    error_code: ?BatchUpdateFindingsV2UnprocessedFindingErrorCode = null,

    /// A detailed description of why a finding could not be processed during a
    /// batch update operation.
    error_message: ?[]const u8 = null,

    /// The finding identifier of an unprocessed finding.
    finding_identifier: ?OcsfFindingIdentifier = null,

    /// The metadata.uid of an unprocessed finding.
    metadata_uid: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .finding_identifier = "FindingIdentifier",
        .metadata_uid = "MetadataUid",
    };
};
