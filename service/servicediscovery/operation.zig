const aws = @import("aws");

const OperationStatus = @import("operation_status.zig").OperationStatus;
const OperationType = @import("operation_type.zig").OperationType;

/// A complex type that contains information about a specified operation.
pub const Operation = struct {
    /// The date and time that the request was submitted, in Unix date/time format
    /// and Coordinated
    /// Universal Time (UTC). The value of `CreateDate` is accurate to milliseconds.
    /// For
    /// example, the value `1516925490.087` represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    create_date: ?i64,

    /// The code associated with `ErrorMessage`. Values for `ErrorCode`
    /// include the following:
    ///
    /// * `ACCESS_DENIED`
    ///
    /// * `CANNOT_CREATE_HOSTED_ZONE`
    ///
    /// * `EXPIRED_TOKEN`
    ///
    /// * `HOSTED_ZONE_NOT_FOUND`
    ///
    /// * `INTERNAL_FAILURE`
    ///
    /// * `INVALID_CHANGE_BATCH`
    ///
    /// * `THROTTLED_REQUEST`
    error_code: ?[]const u8,

    /// If the value of `Status` is `FAIL`, the reason that the operation
    /// failed.
    error_message: ?[]const u8,

    /// The ID of the operation that you want to get information about.
    id: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the namespace associated
    /// with the operation.
    owner_account: ?[]const u8,

    /// The status of the operation. Values include the following:
    ///
    /// **SUBMITTED**
    ///
    /// This is the initial state that occurs immediately after you submit a
    /// request.
    ///
    /// **PENDING**
    ///
    /// Cloud Map is performing the operation.
    ///
    /// **SUCCESS**
    ///
    /// The operation succeeded.
    ///
    /// **FAIL**
    ///
    /// The operation failed. For the failure reason, see `ErrorMessage`.
    status: ?OperationStatus,

    /// The name of the target entity that's associated with the operation:
    ///
    /// **NAMESPACE**
    ///
    /// The namespace ID is returned in the `ResourceId` property.
    ///
    /// **SERVICE**
    ///
    /// The service ID is returned in the `ResourceId` property.
    ///
    /// **INSTANCE**
    ///
    /// The instance ID is returned in the `ResourceId` property.
    targets: ?[]const aws.map.StringMapEntry,

    /// The name of the operation that's associated with the specified ID.
    @"type": ?OperationType,

    /// The date and time that the value of `Status` changed to the current value,
    /// in
    /// Unix date/time format and Coordinated Universal Time (UTC). The value of
    /// `UpdateDate`
    /// is accurate to milliseconds. For example, the value `1516925490.087`
    /// represents
    /// Friday, January 26, 2018 12:11:30.087 AM.
    update_date: ?i64,

    pub const json_field_names = .{
        .create_date = "CreateDate",
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .id = "Id",
        .owner_account = "OwnerAccount",
        .status = "Status",
        .targets = "Targets",
        .@"type" = "Type",
        .update_date = "UpdateDate",
    };
};
