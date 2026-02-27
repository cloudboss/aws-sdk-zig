const DeviceAttribute = @import("device_attribute.zig").DeviceAttribute;

/// Represents information about incompatibility.
pub const IncompatibilityMessage = struct {
    /// A message about the incompatibility.
    message: ?[]const u8,

    /// The type of incompatibility.
    ///
    /// Allowed values include:
    ///
    /// * ARN
    ///
    /// * FORM_FACTOR (for example, phone or tablet)
    ///
    /// * MANUFACTURER
    ///
    /// * PLATFORM (for example, Android or iOS)
    ///
    /// * REMOTE_ACCESS_ENABLED
    ///
    /// * APPIUM_VERSION
    type: ?DeviceAttribute,

    pub const json_field_names = .{
        .message = "message",
        .type = "type",
    };
};
