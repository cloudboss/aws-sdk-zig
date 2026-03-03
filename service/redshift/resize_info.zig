/// Describes a resize operation.
pub const ResizeInfo = struct {
    /// A boolean value indicating if the resize operation can be cancelled.
    allow_cancel_resize: ?bool = null,

    /// Returns the value `ClassicResize`.
    resize_type: ?[]const u8 = null,
};
