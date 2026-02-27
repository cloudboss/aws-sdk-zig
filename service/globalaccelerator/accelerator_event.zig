/// A complex type that contains a `Timestamp` value and `Message` for changes
/// that you make to an accelerator in Global Accelerator. Messages stored here
/// provide progress or error information when
/// you update an accelerator from IPv4 to dual-stack, or from dual-stack to
/// IPv4. Global Accelerator stores a maximum
/// of ten event messages.
pub const AcceleratorEvent = struct {
    /// A string that contains an `Event` message describing changes or errors
    /// when you update an accelerator in Global Accelerator from IPv4 to
    /// dual-stack, or dual-stack to IPv4.
    message: ?[]const u8,

    /// A timestamp for when you update an accelerator in Global Accelerator from
    /// IPv4 to dual-stack, or dual-stack to IPv4.
    timestamp: ?i64,

    pub const json_field_names = .{
        .message = "Message",
        .timestamp = "Timestamp",
    };
};
