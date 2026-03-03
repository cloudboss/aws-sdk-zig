const UnprocessedErrorCode = @import("unprocessed_error_code.zig").UnprocessedErrorCode;
const StandardsControlAssociationUpdate = @import("standards_control_association_update.zig").StandardsControlAssociationUpdate;

/// Provides details about which control's enablement status could not be
/// updated in a
/// specified standard when calling the
/// [BatchUpdateStandardsControlAssociations](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_BatchUpdateStandardsControlAssociations.html) API. This parameter also provides
/// details about why the request was unprocessed.
pub const UnprocessedStandardsControlAssociationUpdate = struct {
    /// The error code for the unprocessed update of the control's enablement status
    /// in the
    /// specified standard. The `NOT_FOUND` value has been deprecated and
    /// replaced by the `RESOURCE_NOT_FOUND` value.
    error_code: UnprocessedErrorCode,

    /// The reason why a control's enablement status in the specified standard
    /// couldn't be updated.
    error_reason: ?[]const u8 = null,

    /// An array of control and standard associations for which an update failed
    /// when calling
    /// [BatchUpdateStandardsControlAssociations](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_BatchUpdateStandardsControlAssociations.html).
    standards_control_association_update: StandardsControlAssociationUpdate,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_reason = "ErrorReason",
        .standards_control_association_update = "StandardsControlAssociationUpdate",
    };
};
