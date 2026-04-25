const WiFiCellular = @import("wi_fi_cellular.zig").WiFiCellular;

/// Optional configuration to customize location estimates.
pub const AdvancedConfiguration = struct {
    /// Configuration for WiFi and cellular-based payloads for location estimates.
    wi_fi_cellular: ?WiFiCellular = null,

    pub const json_field_names = .{
        .wi_fi_cellular = "WiFiCellular",
    };
};
