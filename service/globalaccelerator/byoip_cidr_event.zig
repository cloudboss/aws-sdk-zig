/// A complex type that contains a `Message` and a `Timestamp` value for changes
/// that you make in the status of an IP address range that you bring to Global
/// Accelerator through bring your own IP
/// address (BYOIP).
pub const ByoipCidrEvent = struct {
    /// A string that contains an `Event` message describing changes that you make
    /// in the status
    /// of an IP address range that you bring to Global Accelerator through bring
    /// your own IP address (BYOIP).
    message: ?[]const u8,

    /// A timestamp for when you make a status change for an IP address range that
    /// you bring to Global Accelerator through
    /// bring your own IP address (BYOIP).
    timestamp: ?i64,

    pub const json_field_names = .{
        .message = "Message",
        .timestamp = "Timestamp",
    };
};
