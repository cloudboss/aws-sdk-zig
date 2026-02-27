/// The structure that contains the information required to deliver images to a
/// customer.
pub const ImageGenerationDestinationConfig = struct {
    /// The Amazon Web Services Region of the S3 bucket where images will be
    /// delivered. This `DestinationRegion` must match the Region where the stream
    /// is located.
    destination_region: []const u8,

    /// The Uniform Resource Identifier (URI) that identifies where the images will
    /// be delivered.
    uri: []const u8,

    pub const json_field_names = .{
        .destination_region = "DestinationRegion",
        .uri = "Uri",
    };
};
