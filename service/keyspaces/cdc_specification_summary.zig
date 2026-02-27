const CdcStatus = @import("cdc_status.zig").CdcStatus;
const ViewType = @import("view_type.zig").ViewType;

/// The settings of the CDC stream of the table. For more information about CDC
/// streams, see [Working with change data capture (CDC) streams in Amazon
/// Keyspaces](https://docs.aws.amazon.com/keyspaces/latest/devguide/cdc.html)
/// in the *Amazon Keyspaces Developer Guide*.
pub const CdcSpecificationSummary = struct {
    /// The status of the CDC stream. Specifies if the table has a CDC stream.
    status: CdcStatus,

    /// The view type specifies the changes Amazon Keyspaces records for each
    /// changed row in the stream. This setting can't be changed, after the stream
    /// has been created.
    ///
    /// The options are:
    ///
    /// * `NEW_AND_OLD_IMAGES` - both versions of the row, before and after the
    ///   change. This is the default.
    /// * `NEW_IMAGE` - the version of the row after the change.
    /// * `OLD_IMAGE` - the version of the row before the change.
    /// * `KEYS_ONLY` - the partition and clustering keys of the row that was
    ///   changed.
    view_type: ?ViewType,

    pub const json_field_names = .{
        .status = "status",
        .view_type = "viewType",
    };
};
