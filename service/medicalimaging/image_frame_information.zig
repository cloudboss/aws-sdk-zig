/// Information about the image frame (pixel data) identifier.
pub const ImageFrameInformation = struct {
    /// The image frame (pixel data) identifier.
    image_frame_id: []const u8,

    pub const json_field_names = .{
        .image_frame_id = "imageFrameId",
    };
};
