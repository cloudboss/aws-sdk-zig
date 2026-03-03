/// The status of the transit gateway peering attachment.
pub const PeeringAttachmentStatus = struct {
    /// The status code.
    code: ?[]const u8 = null,

    /// The status message, if applicable.
    message: ?[]const u8 = null,
};
