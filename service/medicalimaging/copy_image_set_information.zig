const CopyDestinationImageSet = @import("copy_destination_image_set.zig").CopyDestinationImageSet;
const CopySourceImageSetInformation = @import("copy_source_image_set_information.zig").CopySourceImageSetInformation;

/// Copy image set information.
pub const CopyImageSetInformation = struct {
    /// The destination image set.
    destination_image_set: ?CopyDestinationImageSet = null,

    /// The source image set.
    source_image_set: CopySourceImageSetInformation,

    pub const json_field_names = .{
        .destination_image_set = "destinationImageSet",
        .source_image_set = "sourceImageSet",
    };
};
