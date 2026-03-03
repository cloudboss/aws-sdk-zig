const ImageUsageResourceType = @import("image_usage_resource_type.zig").ImageUsageResourceType;
const Tag = @import("tag.zig").Tag;

/// The configuration and status of an image usage report.
pub const ImageUsageReport = struct {
    /// The IDs of the Amazon Web Services accounts that were specified when the
    /// report was created.
    account_ids: ?[]const []const u8 = null,

    /// The date and time when the report was created.
    creation_time: ?i64 = null,

    /// The date and time when Amazon EC2 will delete the report (30 days after the
    /// report was
    /// created).
    expiration_time: ?i64 = null,

    /// The ID of the image that was specified when the report was created.
    image_id: ?[]const u8 = null,

    /// The ID of the report.
    report_id: ?[]const u8 = null,

    /// The resource types that were specified when the report was created.
    resource_types: ?[]const ImageUsageResourceType = null,

    /// The current state of the report. Possible values:
    ///
    /// * `available` - The report is available to view.
    ///
    /// * `pending` - The report is being created and not available to view.
    ///
    /// * `error` - The report could not be created.
    state: ?[]const u8 = null,

    /// Provides additional details when the report is in an `error` state.
    state_reason: ?[]const u8 = null,

    /// Any tags assigned to the report.
    tags: ?[]const Tag = null,
};
