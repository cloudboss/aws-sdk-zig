/// A custom AMI available to platforms.
pub const CustomAmi = struct {
    /// THe ID of the image used to create the custom AMI.
    image_id: ?[]const u8,

    /// The type of virtualization used to create the custom AMI.
    virtualization_type: ?[]const u8,
};
