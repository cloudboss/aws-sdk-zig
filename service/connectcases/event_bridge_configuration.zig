const EventIncludedData = @import("event_included_data.zig").EventIncludedData;

/// Configuration to enable EventBridge case event delivery and determine what
/// data is delivered.
pub const EventBridgeConfiguration = struct {
    /// Indicates whether the to broadcast case event data to the customer.
    enabled: bool,

    /// Details of what case and related item data is published through the case
    /// event stream.
    included_data: ?EventIncludedData,

    pub const json_field_names = .{
        .enabled = "enabled",
        .included_data = "includedData",
    };
};
