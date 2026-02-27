/// The structure that contains the information required to deliver a
/// notification to a customer.
pub const NotificationDestinationConfig = struct {
    /// The Uniform Resource Identifier (URI) that identifies where the images will
    /// be delivered.
    uri: []const u8,

    pub const json_field_names = .{
        .uri = "Uri",
    };
};
