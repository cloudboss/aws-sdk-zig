const SbomValidationErrorCode = @import("sbom_validation_error_code.zig").SbomValidationErrorCode;
const SbomValidationResult = @import("sbom_validation_result.zig").SbomValidationResult;

/// A summary of the validation results for a specific software bill of
/// materials (SBOM) attached to a software package version.
pub const SbomValidationResultSummary = struct {
    /// The `errorCode` representing the validation failure error if the SBOM
    /// validation failed.
    error_code: ?SbomValidationErrorCode = null,

    /// The `errorMessage` representing the validation failure error if the SBOM
    /// validation failed.
    error_message: ?[]const u8 = null,

    /// The name of the SBOM file.
    file_name: ?[]const u8 = null,

    /// The end result of the SBOM validation.
    validation_result: ?SbomValidationResult = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .file_name = "fileName",
        .validation_result = "validationResult",
    };
};
