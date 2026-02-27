/// Information about the resize operation for the cluster.
pub const AwsRedshiftClusterResizeInfo = struct {
    /// Indicates whether the resize operation can be canceled.
    allow_cancel_resize: ?bool,

    /// The type of resize operation.
    ///
    /// Valid values: `ClassicResize`
    resize_type: ?[]const u8,

    pub const json_field_names = .{
        .allow_cancel_resize = "AllowCancelResize",
        .resize_type = "ResizeType",
    };
};
