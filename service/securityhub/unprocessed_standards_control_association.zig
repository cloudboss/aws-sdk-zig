const UnprocessedErrorCode = @import("unprocessed_error_code.zig").UnprocessedErrorCode;
const StandardsControlAssociationId = @import("standards_control_association_id.zig").StandardsControlAssociationId;

/// Provides details about which
/// control's enablement status couldn't be retrieved in a specified standard
/// when calling
/// [BatchUpdateStandardsControlAssociations](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_BatchUpdateStandardsControlAssociations.html). This parameter also provides details
/// about why the request was unprocessed.
pub const UnprocessedStandardsControlAssociation = struct {
    /// The error code for the unprocessed standard and control association. The
    /// `NOT_FOUND` value has been deprecated and
    /// replaced by the `RESOURCE_NOT_FOUND` value.
    error_code: UnprocessedErrorCode,

    /// The reason why the standard and control association was unprocessed.
    error_reason: ?[]const u8,

    /// An array with one or more objects that includes a security control
    /// (identified with
    /// `SecurityControlId`, `SecurityControlArn`, or a mix of both
    /// parameters) and the Amazon Resource Name (ARN) of a standard. This parameter
    /// shows the
    /// specific controls for which the enablement status couldn't be retrieved in
    /// specified standards when
    /// calling
    /// [BatchUpdateStandardsControlAssociations](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_BatchUpdateStandardsControlAssociations.html).
    standards_control_association_id: StandardsControlAssociationId,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_reason = "ErrorReason",
        .standards_control_association_id = "StandardsControlAssociationId",
    };
};
