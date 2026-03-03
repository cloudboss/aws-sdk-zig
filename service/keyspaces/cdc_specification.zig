const CdcPropagateTags = @import("cdc_propagate_tags.zig").CdcPropagateTags;
const CdcStatus = @import("cdc_status.zig").CdcStatus;
const Tag = @import("tag.zig").Tag;
const ViewType = @import("view_type.zig").ViewType;

/// The settings for the CDC stream of a table. For more information about CDC
/// streams, see [Working with change data capture (CDC) streams in Amazon
/// Keyspaces](https://docs.aws.amazon.com/keyspaces/latest/devguide/cdc.html)
/// in the *Amazon Keyspaces Developer Guide*.
pub const CdcSpecification = struct {
    /// Specifies that the stream inherits the tags from the table.
    propagate_tags: ?CdcPropagateTags = null,

    /// The status of the CDC stream. You can enable or disable a stream for a
    /// table.
    status: CdcStatus,

    /// The tags (key-value pairs) that you want to apply to the stream.
    tags: ?[]const Tag = null,

    /// The view type specifies the changes Amazon Keyspaces records for each
    /// changed row in the stream. After you create the stream, you can't make
    /// changes to this selection.
    ///
    /// The options are:
    ///
    /// * `NEW_AND_OLD_IMAGES` - both versions of the row, before and after the
    ///   change. This is the default.
    /// * `NEW_IMAGE` - the version of the row after the change.
    /// * `OLD_IMAGE` - the version of the row before the change.
    /// * `KEYS_ONLY` - the partition and clustering keys of the row that was
    ///   changed.
    view_type: ?ViewType = null,

    pub const json_field_names = .{
        .propagate_tags = "propagateTags",
        .status = "status",
        .tags = "tags",
        .view_type = "viewType",
    };
};
