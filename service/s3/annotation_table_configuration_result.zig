const AnnotationConfigurationState = @import("annotation_configuration_state.zig").AnnotationConfigurationState;
const ErrorDetails = @import("error_details.zig").ErrorDetails;

/// Contains the current state of the annotation table associated with a
/// bucket's Amazon S3 Metadata
/// configuration, including its provisioning status and identifiers.
pub const AnnotationTableConfigurationResult = struct {
    /// The current configuration state of the annotation table.
    configuration_state: AnnotationConfigurationState,

    @"error": ?ErrorDetails = null,

    /// The ARN of the IAM role associated with the annotation table.
    role: ?[]const u8 = null,

    /// The ARN of the annotation table.
    table_arn: ?[]const u8 = null,

    /// The name of the annotation table.
    table_name: ?[]const u8 = null,

    /// The provisioning status of the annotation table. Possible values:
    /// `CREATING`, `BACKFILLING`, `ACTIVE`, `FAILED`.
    table_status: ?[]const u8 = null,
};
